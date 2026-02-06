--Cursorline
MiniDeps.add({
	source = "https://github.com/ya2s/nvim-cursorline",
})

MiniDeps.later(require("nvim-cursorline").setup({
	cursorline = {
		enable = true,
		timeout = 10,
		number = true,
	},
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = false },
	},
}))
