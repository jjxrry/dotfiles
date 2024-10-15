return {
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     -- Optional: You can set Catppuccin flavor (latte, frappe, macchiato, mocha)
  --     require('catppuccin').setup {
  --       flavour = 'mocha', -- Or any other theme variant
  --     }
  --     vim.cmd.colorscheme 'catppuccin' -- Set the color scheme here
  --   end,
  -- },
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   priority = 1000,
  --   config = function()
  --     require('rose-pine').setup {
  --       variant = 'moon',
  --     }
  --
  --     -- Load the colorscheme
  --     vim.cmd.colorscheme 'rose-pine'
  --   end,
  -- },
  {
    'EdenEast/nightfox.nvim',
    name = 'nightfox',
    priority = 1000,
    config = function()
      require('nightfox').setup {
        variant = 'nightfox',
      }
      -- Load the colorscheme
      vim.cmd.colorscheme 'nightfox'
    end,
  },
  -- {
  --   'sainnhe/gruvbox-material',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.cmd.colorscheme 'gruvbox-material'
  --   end,
  -- },
  -- {
  --   'sainnhe/everforest',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.everforest_enable_italic = true
  --     vim.g.everforest_background = 'hard'
  --     vim.cmd.colorscheme 'everforest'
  --   end,
  -- },
  -- {
  --   'sainnhe/edge',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.edge_style = 'aura'
  --     vim.g.edge_enable_italic = true
  --     vim.cmd.colorscheme 'edge'
  --   end,
  -- },
  -- {
  --   'sainnhe/sonokai',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.sonokai_style = 'andromeda'
  --     vim.g.sonokai_enable_italic = true
  --     vim.cmd.colorscheme 'sonokai'
  --   end,
  -- },
}
