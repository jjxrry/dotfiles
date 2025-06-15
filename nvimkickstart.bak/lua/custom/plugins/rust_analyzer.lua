return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        cmd = { vim.fn.expand '~/.cargo/bin/rust-analyzer' },
      },
    }
  end,
}
