MiniDeps.add({
	source = "folke/lazydev.nvim",
	ft = "lua",
})

MiniDeps.later(function()
	require("lazydev").setup({
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	})
end)
