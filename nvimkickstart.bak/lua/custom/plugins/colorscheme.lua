return {
  {
    '0xstepit/flow.nvim',
    lazy = false,
    priority = 1000,
    tag = 'v2.0.1',
    opts = {
      theme = {
        style = 'dark', --  "dark" | "light"
        contrast = 'high', -- "default" | "high"
        transparent = false, -- true | false
      },
      colors = {
        mode = 'dark', -- "default" | "dark" | "light"
        fluo = 'pink', -- "pink" | "cyan" | "yellow" | "orange" | "green"
        custom = {
          saturation = '75', -- "" | string representing an integer between 0 and 100
          light = '82', -- "" | string representing an integer between 0 and 100
        },
      },
      ui = {
        borders = 'theme', -- "theme" | "inverse" | "fluo" | "none"
        aggressive_spell = false, -- true | false
      },
    },
    config = function(_, opts)
      require('flow').setup(opts)
      vim.cmd 'colorscheme flow'
    end,
  },
}
