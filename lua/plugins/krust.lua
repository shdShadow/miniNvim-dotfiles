MiniDeps.add({
  source = "alexpasmantier/krust.nvim"
})

MiniDeps.later(
function()
  require('krust').setup()
end
)
