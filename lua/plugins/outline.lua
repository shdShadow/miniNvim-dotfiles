MiniDeps.add({
	source = "hedyhli/outline.nvim",
})

MiniDeps.now(function()
	require("outline").setup()
	vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
end)
