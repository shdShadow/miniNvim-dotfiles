MiniDeps.add({
	source = "jalvesaq/zotcite",
	depends = {
		{ source = "nvim-treesitter/nvim-treesitter" },
		{ source = "nvim-telescope/telescope.nvim" },
	},
})

MiniDeps.now(function()
	require("zotcite").setup({})
end)
