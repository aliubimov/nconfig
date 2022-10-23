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

require("lsp_signature").setup(signature_config)

lspconfig.sumneko_lua.setup({})
lspconfig.texlab.setup({})
lspconfig.jdtls.setup({})
lspconfig.clangd.setup({})
