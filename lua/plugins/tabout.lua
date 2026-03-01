MiniDeps.add({
	source = "abecodes/tabout.nvim",
})
MiniDeps.now(function()
	require("tabout").setup()
end)
