MiniDeps.add({
	source = "MeanderingProgrammer/render-markdown.nvim",
	depends = {
		{ source = "nvim-treesitter/nvim-treesitter" },
		{ source = "nvim-mini/mini.nvim" },
	},
})

MiniDeps.later(function()
	require("render-markdown").setup({})
end)
