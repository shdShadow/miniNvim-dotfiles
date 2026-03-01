-- Register plugin
MiniDeps.add({
	source = "obsidian-nvim/obsidian.nvim",
	checkout = "*",
	depends = { "nvim-lua/plenary.nvim" },
})

MiniDeps.later(function()
	local vault = vim.fn.expand("/home/umbra/Documents/Obsidian Vault")
	local attachments = vault .. "/Attachments"

	require("obsidian").setup({
		templates = {
			enabled = true,
			folder = "/home/umbra/Documents/Obsidian Vault/Templates",
		},
		note = {
			--template = vim.NIL, -- disables the default note template and just use a blank note
			template = "/home/umbra/Documents/Obsidian Vault/Templates/default.md", -- A template you can define your self
		},

		legacy_commands = false,
		workspaces = {
			{ name = "uni", path = "/home/umbra/Documents/Obsidian Vault" },
		},
		ui = { enable = false },
		attachments = {
			folder = "Attachments",
		},
		picker = {
			name = "telescope.nvim",
			picker_config = {
				path_display = { "hidden" },
			},
		},
		-- Prevent the plugin to give a random id, and use the alias specified as
		-- the file name
		note_id_func = function(title)
			if title ~= nil then
				return title:gsub(" ", "-")
			else
				-- fallback
				return tostring(os.time())
			end
		end,
	}) -- ← only this closing
	--vim.keymap.set("n", "fll", ":Obsidian follow_link<CR>", { desc = "Obsidian Follow Link" })
	vim.keymap.set("n", "flv", ":Obsidian follow_link vsplit<CR>", { desc = "Obsidian follow_link vsplit" })
	vim.keymap.set("n", "flx", ":Obsidian follow_link hsplit<CR>", { desc = "Obsidian follow_link hsplit" })
	vim.keymap.set("n", "<C-v>", ":Obsidian paste_img<CR>", { desc = "Obsidian paste image" })
	vim.keymap.set("n", "<leader>onn", ":Obsidian new<CR>", { desc = "Obsidian new note " })
	vim.keymap.set("n", "oqs", ":Obsidian quick_switch<CR>", { desc = "Obsidian quick switch to note" })
	--vim.keymap.set("n", "<leader>ont", ":Obsidian new_from_template<CR>", { desc = "Obsidian new note from template" })
	vim.keymap.set("n", "osf", ":Obsidian search<CR>", { desc = "Obsidian search file" })
	vim.keymap.set("n", "ott", ":Obsidian tags<CR>", { desc = "Obsidian tags" })
	vim.keymap.set("n", "orn", ":Obsidian rename<CR>", { desc = "Obsidian rename" })
	vim.keymap.set("v", "oxt", ":Obsidian extract_note<CR>", { desc = "Obsidian extract" })
end)
