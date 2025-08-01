return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function ()
            local lsp_zero = require('lsp-zero')
            local lspconfig = require('lspconfig')
            local cmp = require ("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local mappings = {
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<Esc>"]= cmp.mapping.abort(),
                ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
            }

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions

                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true })
                -- NOTE: Remember that lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself
                -- many times.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.

                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
                end

                map("<leader>lk", function ()
                    local id = vim.fn.input("Process ID: ")
                    vim.cmd("LspStop " .. id)
                end, "[L]sp Stop")

                map("<leader>lb", function ()
                    local id = vim.fn.input("Config Name: ")
                    vim.cmd("LspStart " .. id)
                end, "[L]sp Start")
                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-T>.
                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                -- Find references for the word under your cursor.
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                -- Fuzzy find all the symbols in your current workspace
                --  Similar to document symbols, except searches over your whole project.
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- Rename the variable under your cursor
                --  Most Language Servers support renaming across files, etc.
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap
                map('K', vim.lsp.buf.hover, 'Hover Documentation')

                map('<leader>h', vim.diagnostic.open_float, 'Hover Diagnostics')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end)

            lsp_zero.set_preferences({ sign_icons = {} })

            cmp.setup({
                mapping = mappings
            })

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { "astro", "denols", "gopls", "cssls", "html", "htmx", "lua_ls", "svelte", "ts_ls", "emmet_ls" },
                handlers = {
                    lsp_zero.default_setup,
                    qmlls = function()
                        lspconfig.qmlls.setup({
                            cmd = { "qmlls", "-E" }
                        })
                    end,
                    emmet_ls = function()
                        lspconfig.emmet_ls.setup({
                            filetypes = { "css", "html" },
                            -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
                            -- **Note:** only the options listed in the table are supported.
                            init_options = {
                                ---@type table<string, string>
                                includeLanguages = {},
                                --- @type string[]
                                excludeLanguages = {},
                                --- @type string[]
                                extensionsPath = {},
                                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                                preferences = {},
                                --- @type boolean Defaults to `true`
                                showAbbreviationSuggestions = true,
                                --- @type "always" | "never" Defaults to `"always"`
                                showExpandedAbbreviation = "always",
                                --- @type boolean Defaults to `false`
                                showSuggestionsAsSnippets = false,
                                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                                syntaxProfiles = {},
                                --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                                variables = {},
                            }
                        })
                    end,
                    gopls = function()
                        lspconfig.gopls.setup({
                            root_dir = lspconfig.util.root_pattern("go.mod", "go.sum"),
                            settings = {
                                gopls = {
                                    usePlaceholders = false,
                                    analyses = {
                                        unusedparams = true
                                    },
                                    staticcheck = true,
                                    gofumpt = true
                                }
                            }
                        })
                    end,
                    ts_ls = function()
                        lspconfig.ts_ls.setup({
                            root_dir = lspconfig.util.root_pattern("package.json"),
                            init_options = {
                                single_file_supper = false
                            },
                            on_attach = function()
                                local active_clients = vim.lsp.get_active_clients()
                                local ts
                                local denoon = false

                                for _, client in pairs(active_clients) do
                                    if client.name == "ts_ls" then
                                        ts = client
                                    end
                                    if client.name == "denols" then
                                        denoon = true
                                    end
                                end

                                if ts and denoon then
                                    ts.stop()
                                end
                            end,
                        })
                    end,
                    denols = function()
                        lspconfig.denols.setup({
                            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
                            filetypes = { "typescript" },
                            init_options = {
                                lint = true,
                                unstable = true,
                            },
                            on_attach = function()
                                local active_clients = vim.lsp.get_active_clients()
                                for _, client in pairs(active_clients) do
                                    if client.name == "ts_ls" then
                                        client.stop()
                                    end
                                end
                            end,
                            settings = {
                                deno = {
                                    enable = true,
                                    suggest = {
                                        imports = {
                                            autoDiscover = true,
                                            hosts = {
                                                ["https://jsr.io"] = true,
                                                ["https://deno.land"] = true
                                            }
                                        }
                                    }
                                }
                            }
                        })
                    end
                }
            })

        end
    },

}

