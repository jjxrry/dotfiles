local function pwd()
  return vim.fn.getcwd()
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'edge',
    },
    sections = {
      lualine_c = { pwd },
    },
  },
}
