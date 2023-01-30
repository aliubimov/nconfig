local status_ok, _ = pcall(require, "mason")
if not status_ok then
  return
end

require("mason").setup()
require("mason-lspconfig").setup()

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },

  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),

  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

local signature_config = {
  log_path = vim.fn.expand("$HOME") .. "/tmp/sig.log",
  debug = true,
  hint_enable = false,
  handler_opts = { border = "single" },
  max_width = 80,
}


local jdtcfg = {
    settings = {
      java = {signatureHelp = {enabled = true}, contentProvider = {preferred = 'fernflower'}}
    },
    on_init = function(client)
      if client.config.settings then
        client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
      end
    end
}

-- require("lsp_signature").setup(signature_config)

-- lspconfig.sumneko_lua.setup({})
-- lspconfig.texlab.setup({})
---- lspconfig.jdtls.setup(jdtcfg)
-- lspconfig.jdtls.setup({})
--lspconfig.clangd.setup({})
--lspconfig.pyright.setup({})

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,

    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    --["rust_analyzer"] = function ()
    --    require("rust-tools").setup {}
    --end
}

