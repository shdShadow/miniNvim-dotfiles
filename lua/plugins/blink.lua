MiniDeps.add({
	source = "saghen/blink.cmp",
	depends = {
		{ source = "rafamadriz/friendly-snippets" },
		{ source = "onsails/lspkind.nvim" },
	},
})

MiniDeps.later(function()
	local lspkind = require("lspkind")
	lspkind.init()
	require("blink.cmp").setup({
		keymap = {
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},

		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 500,
				treesitter_highlighting = true,
				window = { border = "rounded" },
			},
			menu = {
				border = "rounded",
				cmdline_position = function()
					if vim.g.ui_cmdline_pos ~= nil then
						local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
						return { pos[1] - 1, pos[2] }
					end
					local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
					return { vim.o.lines - height, 0 }
				end,
				draw = {
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind" },
					},
					components = {
						kind_icon = {
							text = function(item)
								local kind = require("lspkind").symbol_map[item.kind] or ""
								return kind .. " "
							end,
							highlight = "CmpItemKind",
						},
						label = {
							text = function(item)
								return item.label
							end,
							highlight = "CmpItemAbbr",
						},
						kind = {
							text = function(item)
								return item.kind
							end,
							highlight = "CmpItemKind",
						},
					},
				},
			},
		},

		sources = {
			-- 'omni' is already in your list here, which is good
			default = { "lsp", "path", "snippets", "lazydev", "omni", "buffer" },
			providers = {
				lazydev = {
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				-- 1. Remove the 'nvlime' wrapper.
				-- 2. Configure 'omni' directly.
				omni = {
					name = "Omni",
					module = "blink.cmp.sources.complete_func",
					-- This ensures blink uses the nvlime#plugin#CompleteFunc
					enabled = function()
						return vim.bo.filetype == "lisp" and vim.bo.omnifunc ~= ""
					end,
					score_offset = 100, -- Give Lisp suggestions priority
				},
			},
		},
		snippets = { preset = "luasnip" },

		fuzzy = { implementation = "lua" },

		signature = { enabled = true },
	})
end)
