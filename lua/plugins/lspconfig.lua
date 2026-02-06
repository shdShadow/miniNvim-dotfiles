MiniDeps.add({
	source = "neovim/nvim-lspconfig",
	depends = {
		{ source = "mason-org/mason.nvim", opts = {} },
		{ source = "mason-org/mason-lspconfig.nvim" },
		{ source = "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ source = "j-hui/fidget.nvim", opts = {} },
		{ source = "saghen/blink.cmp" },
	},
})

MiniDeps.now(function()
	---------------------------------------------------------------------------
	-- LSP ATTACH
	---------------------------------------------------------------------------
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			-- Keymaps --------------------------------------------------------------
			map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

			-- Compatibility helper ------------------------------------------------
			local function client_supports_method(client, method, bufnr)
				if vim.fn.has("nvim-0.11") == 1 then
					return client:supports_method(method, bufnr)
				else
					return client.supports_method(method, { bufnr = bufnr })
				end
			end

			-----------------------------------------------------------------------
			-- Document highlight autocommands
			-----------------------------------------------------------------------
			local client = vim.lsp.get_client_by_id(event.data.client_id)

			if
				client
				and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
			then
				local highlight_group = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_group,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_group,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(ev2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = ev2.buf })
					end,
				})
			end

			-----------------------------------------------------------------------
			-- Inlay hints toggle
			-----------------------------------------------------------------------
			if
				client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
			then
				map("<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "Toggle [I]nlay [H]ints")
			end
		end, -- callback
	}) -- autocmd

	---------------------------------------------------------------------------
	-- Diagnostics
	---------------------------------------------------------------------------
	vim.diagnostic.config({
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = vim.diagnostic.severity.ERROR },
		signs = vim.g.have_nerd_font and {
			text = {
				[vim.diagnostic.severity.ERROR] = "󰅚 ",
				[vim.diagnostic.severity.WARN] = "󰀪 ",
				[vim.diagnostic.severity.INFO] = "󰋽 ",
				[vim.diagnostic.severity.HINT] = "󰌶 ",
			},
		} or {},
		virtual_text = {
			source = "if_many",
			spacing = 2,
			format = function(diag)
				return diag.message
			end,
		},
	})

	---------------------------------------------------------------------------
	-- LSP Setup (Mason + LSPConfig + Blink capabilities)
	---------------------------------------------------------------------------
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	require("mason").setup()
	require("mason-tool-installer").setup({ ensure_installed = {} })

	-- You had 4 copies — cleaned to a single correct block
	local servers = {} -- define this if you want to override specific servers

	require("mason-lspconfig").setup({
		ensure_installed = {},
		automatic_installation = true,

		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end)
