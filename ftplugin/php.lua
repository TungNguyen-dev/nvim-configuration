local options = {
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation.
  tabstop = 4,                             -- insert 2 spaces for a tab.
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
