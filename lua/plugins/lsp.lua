return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lua',
		-- Snippets
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets',
		-- Clangd extensions
		'p00f/clangd_extensions.nvim',
	},
	config = function()
		-- ===============================
		-- LSP & formatting setup
		-- ===============================
		local autoformat_filetypes = { "lua", "verilog", "systemverilog" }

		local on_attach = function(client, bufnr)
			-- Autoformat on save
			if vim.tbl_contains(autoformat_filetypes, vim.bo.filetype) then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							async = false,
						})
					end
				})
			end

			-- Keymaps
			local opts = { buffer = bufnr }
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
			vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
			vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
			vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
			vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
		end

		-- ===============================
		-- Mason setup
		-- ===============================
		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = { "lua_ls", "pyright", "ts_ls", "eslint", "clangd", "verible" }
		})

		-- ===============================
		-- LSP capabilities (for cmp)
		-- ===============================
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- ===============================
		-- Diagnostics & floating windows
		-- ===============================
		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = true,
			float = { border = 'rounded', style = 'minimal' },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = '✘',
					[vim.diagnostic.severity.WARN]  = '▲',
					[vim.diagnostic.severity.HINT]  = '⚑',
					[vim.diagnostic.severity.INFO]  = '»',
				},
			},
		})

		vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
			vim.lsp.handlers.hover, { border = 'rounded' }
		)
		vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
			vim.lsp.handlers.signature_help, { border = 'rounded' }
		)

		-- ===============================
		-- Setup servers using new API
		-- ===============================

		-- Lua
		vim.lsp.config.lua_ls = {
			cmd = { 'lua-language-server' },
			filetypes = { 'lua' },
			root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = { version = 'LuaJIT' },
					diagnostics = { globals = { 'vim' } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					telemetry = { enable = false },
				},
			},
		}

		-- Pyright
		vim.lsp.config.pyright = {
			cmd = { 'pyright-langserver', '--stdio' },
			filetypes = { 'python' },
			root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- TS/JS
		vim.lsp.config.ts_ls = {
			cmd = { 'typescript-language-server', '--stdio' },
			filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
			root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- ESLint
		vim.lsp.config.eslint = {
			cmd = { 'vscode-eslint-language-server', '--stdio' },
			filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue', 'svelte', 'astro' },
			root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json', 'eslint.config.js', 'package.json', '.git' },
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- Verilog
		vim.lsp.config.verible = {
			cmd = { 'verible-verilog-ls' },
			filetypes = { 'verilog', 'systemverilog' },
			root_markers = { '.git' },
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- Clangd
		vim.lsp.config.clangd = {
			cmd = {
				'clangd',
				'--background-index',
				'--completion-style=detailed',
				'--header-insertion=iwyu',
			},
			filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
			root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- Enable the servers
		vim.lsp.enable({ 'lua_ls', 'pyright', 'ts_ls', 'eslint', 'verible', 'clangd' })

		-- Setup clangd extensions separately
		require("clangd_extensions").setup({
			server = {
				-- Leave empty since we're configuring via vim.lsp.config
			}
		})

		-- ===============================
		-- CMP setup
		-- ===============================
		local cmp = require('cmp')
		require('luasnip.loaders.from_vscode').lazy_load()
		vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

		cmp.setup({
			preselect = 'item',
			completion = { completeopt = 'menu,menuone,noinsert' },
			window = { documentation = cmp.config.window.bordered() },
			snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
			sources = {
				{ name = 'path' },
				{ name = 'nvim_lsp' },
				{ name = 'buffer',  keyword_length = 3 },
				{ name = 'luasnip', keyword_length = 2 },
			},
			mapping = cmp.mapping.preset.insert({
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				['<C-f>'] = cmp.mapping.scroll_docs(5),
				['<C-u>'] = cmp.mapping.scroll_docs(-5),
				['<C-e>'] = cmp.mapping(function(fallback)
					if cmp.visible() then cmp.abort() else cmp.complete() end
				end),
				['<Tab>'] = cmp.mapping(function(fallback)
					local col = vim.fn.col('.') - 1
					if cmp.visible() then
						cmp.select_next_item({ behavior = 'select' })
					elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
						fallback()
					else
						cmp.complete()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
				['<C-d>'] = cmp.mapping(function(fallback)
					local luasnip = require('luasnip')
					if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end
				end, { 'i', 's' }),
				['<C-b>'] = cmp.mapping(function(fallback)
					local luasnip = require('luasnip')
					if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
				end, { 'i', 's' }),
			}),
		})
	end
}
