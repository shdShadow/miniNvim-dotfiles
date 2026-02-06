-- lua/plugins/init.lua

-- List all plugin modules in this folder
local modules = {
	"telescope", --ok
	"conform", --ok
	"globals", --ok
	"colorscheme", --ok
	"cursorline", --ok
	"nvim-tmux", --ok
	"gitsigns", --ok
	"web-devicons", --ok
	"lazydev", --ok
	"guess-indent", --ok
	"which-key", --ok
	"lspconfig", --ok
	"blink", --ok
	--"nvim-cmp",
	"luasnip", --ok
	"wrapper",
	"lualine", --ok
	"treesitter",
	"markdown",
	"blink-indent",
	"krust",
	"zen-mode",
	"limelight",
	"outline",
	--"obsidian",
	"nvlime",
	--"zotcite",
	-- add more files here
}

for _, m in ipairs(modules) do
	local ok, err = pcall(require, "plugins." .. m)
	if not ok then
		vim.notify("Error loading plugins/" .. m .. ": " .. err, vim.log.levels.ERROR)
	end
end
