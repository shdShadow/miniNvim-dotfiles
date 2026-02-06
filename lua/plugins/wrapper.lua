MiniDeps.add({
	source = "andrewferrier/wrapping.nvim",
})

MiniDeps.now(function()
	require("wrapping").setup()
end)
