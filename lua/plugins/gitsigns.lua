--Gitsigns
MiniDeps.add({
	source = "lewis6991/gitsigns.nvim",
})

MiniDeps.later(function()
	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	})
end)
