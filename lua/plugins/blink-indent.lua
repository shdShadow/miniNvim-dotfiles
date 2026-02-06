MiniDeps.add({
	source = "saghen/blink.indent",
})

MiniDeps.later(function()
	require("blink.indent").setup()
end)
