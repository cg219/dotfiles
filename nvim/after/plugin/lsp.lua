local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')
local cmp = require ("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local mappings = {
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
    ["<Esc>"]= cmp.mapping.abort(),
    ["<C-[>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-]>"] = cmp.mapping.select_next_item(cmp_select),
}

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

lsp_zero.set_preferences({ sign_icons = {} })

cmp.setup({
    mapping = mappings
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "astro", "denols", "gopls", "cssls", "html", "htmx", "lua_ls", "svelte", "tsserver", "swift_mesonls" },
  handlers = {
    lsp_zero.default_setup,
    tsserver = function()
        lspconfig.tsserver.setup({
            root_dir = lspconfig.util.root_pattern("package.json"),
            init_options = {
                single_file_supper = false
            }
        })
    end,
    denols = function()
        lspconfig.denols.setup({
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            init_options = {
                lint = true,
                unstable = true,
            },
            settings = {
                deno = {
                    enable = true,
                    suggest = {
                        imports = {
                            autoDiscover = true,
                            hosts = {
                                ["https://deno.land/"] = true
                            }
                        }
                    }
                }
            }
        })
    end
  }
})
