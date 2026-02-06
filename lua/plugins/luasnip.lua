local snippets = require("blink.cmp.config.snippets")
MiniDeps.add({
	source = "L3MON4D3/LuaSnip",
	build = (function()
		if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
			return
		end
		return "make install_jsregexp"
	end)(),
})

MiniDeps.later(function()
	-- Load VSCode-format snippets
	require("luasnip.loaders.from_vscode").lazy_load()
end)
