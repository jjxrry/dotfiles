return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
    pre_hook = function(ctx)
      -- Use ts_context_commentstring to determine comment string for tsx/jsx files
      return require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()(ctx)
    end,
  },
}
