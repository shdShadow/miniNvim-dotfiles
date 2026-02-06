-- TELESCOPE
MiniDeps.add({
	source = "nvim-telescope/telescope.nvim",
	depends = {
		"nvim-lua/plenary.nvim",
	},
})

-- TELESCOPE FZF PLUGIN
MiniDeps.add({
	source = "nvim-telescope/telescope-fzf-native.nvim",
	hook = {
		post_checkout = function(path)
			vim.system({ "make" }, { cwd = path }):wait()
		end,
	},
})

-- TELESCOPE UI SELECT PLUGIN
MiniDeps.add({
	source = "nvim-telescope/telescope-ui-select.nvim",
})

MiniDeps.now(function()
	-- useful locals
	local builtin = require("telescope.builtin")

	-- load extensions
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("ui-select")

	-- File picker keybinds
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
	vim.keymap.set("n", "<leader>flg", builtin.live_grep, { desc = "Telescope live grep" })
	vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, {
		desc = "Telescope search string under cursor",
	})

	-- Vim picker keybinds
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
	vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "List recent files" })
	vim.keymap.set("n", "qf", builtin.quickfix, { desc = "List quickfix items" })

	-- Shortcut to directly open Neovim config files
	vim.keymap.set("n", "<leader>fp", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "Search Neovim config files" })

	-- Fuzzy find in current buffer (dropdown)
	vim.keymap.set("n", "<leader>/", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "Fuzzily search in current buffer" })

	-- Live grep open files only
	vim.keymap.set("n", "<leader>s/", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "Search in open files" })
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})
end)
