local function pwd()
  local cwd = vim.fn.expand '%:p:h'
  local file = vim.fn.expand '%:t'
  cwd = cwd:gsub('^/Users/jerrygao/', '', 2)
  return cwd .. '/' .. file
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- options = {
    --   theme = 'edge',
    -- },
    sections = {
      lualine_c = { pwd },
    },
  },
}
