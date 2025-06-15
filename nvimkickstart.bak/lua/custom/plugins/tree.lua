return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 32, -- Sets the tree width to 40 columns
        },
        git = {
          ignore = false, -- Show gitignored files
        },
        filters = {
          dotfiles = false, -- Show hidden files (dotfiles)
        },
      }
      vim.keymap.set('n', '<leader>k', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'Toggle file tree' })
    end,
  },
}
