--GUESS INDENT
MiniDeps.add({
	source = "NMAC427/guess-indent.nvim",
})

MiniDeps.later(function()
	require("guess-indent").setup()
end)
