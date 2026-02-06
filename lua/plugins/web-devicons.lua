MiniDeps.add({
	source = "nvim-tree/nvim-web-devicons",
})

MiniDeps.now(function()
	require("nvim-web-devicons").setup()
end)
