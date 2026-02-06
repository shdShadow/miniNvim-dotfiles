-- Register plugin
MiniDeps.add({
	source = "obsidian-nvim/obsidian.nvim",
	checkout = "*",
	depends = { "nvim-lua/plenary.nvim" },
})

MiniDeps.later(function()
	require("obsidian").setup({
		legacy_commands = false,
		workspaces = {
			{ name = "uni", path = "~/notes/" },
		},
	})
end)
