MiniDeps.add({
	source = "junegunn/limelight.vim",
})

MiniDeps.now(function()
	vim.g.limelight_conceal_ctermfg = "gray"
end)
