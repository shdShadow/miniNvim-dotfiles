MiniDeps.add({
	source = "hrsh7th/nvim-cmp",
	depends = {
		{ source = "neovim/nvim-lspconfig" },
		{ source = "hrsh7th/cmp-nvim-lsp" },
		{ source = "hrsh7th/cmp-buffer" },
		{ source = "hrsh7th/cmp-path" },
		{ source = "hrsh7th/cmp-cmdline" },
		{ source = "hrsh7th/nvim-cmp" },
	},
})

MiniDeps.now(function()
	-- Minimal nvim-cmp + LuaSnip setup
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- Use LuaSnip
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-Space>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	})

	-- Command-line completion
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = { { name = "buffer" } },
	})

	-- LSP capabilities
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- lspconfig.tsserver.setup { capabilities = capabilities }

	-- Optional: Load friendly-snippets (community snippet collection)
	require("luasnip.loaders.from_vscode").lazy_load()
end)
