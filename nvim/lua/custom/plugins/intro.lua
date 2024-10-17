-- Alpha (dashboard) for neovim

local options

vim.opt.termguicolors = true -- Enable true color

-- Only runs this script if Alpha Screen loads -- only if there isn't files to read
if vim.api.nvim_exec('echo argc()', true) == '0' then
  math.randomseed(os.time()) -- For random header.

  -- To split our quote, artist and source.
  -- And automatically center it for screen loader of the header.
  local function split(s)
    local t = {}
    local max_line_length = vim.api.nvim_get_option 'columns'
    local longest = 0 -- Value of longest string is 0 by default
    for far in s:gmatch '[^\r\n]+' do
      -- Break the line if it's actually bigger than terminal columns
      local line
      far:gsub('(%s*)(%S+)', function(spc, word)
        if not line or #line + #spc + #word > max_line_length then
          table.insert(t, line)
          line = word
        else
          line = line .. spc .. word
          longest = max_line_length
        end
      end)
      -- Get the string that is the longest
      if #line > longest then
        longest = #line
      end
      table.insert(t, line)
    end
    -- Center all strings by the longest
    for i = 1, #t do
      local space = longest - #t[i]
      local left = math.floor(space / 2)
      local right = space - left
      t[i] = string.rep(' ', left) .. t[i] .. string.rep(' ', right)
    end
    return t
  end

  -- Function to retrieve console output.
  local function capture(cmd)
    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read '*a')
    handle:close()
    return output
  end

  -- Create button for initial keybind.
  --- @param sc string
  --- @param txt string
  --- @param hl string
  --- @param keybind string optional
  --- @param keybind_opts table optional
  local function button(sc, txt, hl, keybind, keybind_opts)
    local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

    local opts = {
      position = 'center',
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = 'right',
      hl = hl,
      hl_shortcut = hl,
    }

    if keybind then
      keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
      opts.keymap = { 'n', sc_, keybind, keybind_opts }
    end

    local function on_press()
      local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, 'normal', false)
    end

    return {
      type = 'button',
      val = txt,
      on_press = on_press,
      opts = opts,
    }
  end

  -- All custom headers
  Headers = {
    {
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⡤⠤⠤⠤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠞⠋⠁⠀⠀⠀⠀⠀⠀⠀⠉⠛⢦⣤⠶⠦⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⢀⣴⠞⢋⡽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⠀⠙⢶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⣰⠟⠁⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡀⠀⠀⠉⠓⠦⣤⣤⣤⣤⣤⣤⣄⣀⠀⠀⠀]],
      [[⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣷⡄⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣆⠀]],
      [[⠀⠀⣠⠞⠁⠀⠀⣀⣠⣏⡀⠀⢠⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⠿⡃⠀⠀⠄⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡆]],
      [[⢀⡞⠁⠀⣠⠶⠛⠉⠉⠉⠙⢦⡸⣿⡿⠀⠀⠀⡄⢀⣀⣀⡶⠀⠀⠀⢀⡄⣀⠀⣢⠟⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃]],
      [[⡞⠀⠀⠸⠁⠀⠀⠀⠀⠀⠀⠀⢳⢀⣠⠀⠀⠀⠉⠉⠀⠀⣀⠀⠀⠀⢀⣠⡴⠞⠁⠀⠀⠈⠓⠦⣄⣀⠀⠀⠀⠀⣀⣤⠞⠁⠀]],
      [[⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠀⠁⠀⢀⣀⣀⡴⠋⢻⡉⠙⠾⡟⢿⣅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠉⠉⠀⠀⠀⠀]],
      [[⠘⣦⡀⠀⠀⠀⠀⠀⠀⣀⣤⠞⢉⣹⣯⣍⣿⠉⠟⠀⠀⣸⠳⣄⡀⠀⠀⠙⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠈⠙⠒⠒⠒⠒⠚⠋⠁⠀⡴⠋⢀⡀⢠⡇⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀⢀⡾⠋⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⢸⡀⠸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⠀⠀⠉⠋⠻⣄⠀⠀⠀⠀⠀⣀⣠⣴⠞⠋⠳⠶⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⠦⢤⠤⠶⠋⠙⠳⣆⣀⣈⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    },
    {
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣼⠃⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠇⠀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡏⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⣀⣤⣿⣿⡾⠛⠉⣉⣽⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠶⠛⢛⣿⣿⣷⣶⣤⣀⠀⠀⠀⠀⠀⠀⢸⣿⡀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⢰⣾⠛⢉⣵⡟⣃⣤⣶⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⣠⣾⠏⣡⣴⣾⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⢈⡹⣇⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠙⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣀⣀⣀⣰⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠶⠖⠲⠾⣿⣿⣦⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⣠⣴⡾⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠈⠙⢿⣄⠀⠀⠀⠀',
      '⠀⠀⠀⣿⡛⠉⠁⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⣄⠀⠀',
      '⠀⠀⠀⣾⣷⣦⣀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣧⠀',
      '⠀⡀⠈⠻⢿⣿⣿⣷⠆⠀⠙⠻⠿⣿⣿⡿⢿⣿⠋⠀⠀⠀⣴⠇⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡆',
      '⠀⠻⣟⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠿⣿⣆⣀⣠⣼⢿⣧⠀⠀⠀⢀⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⠿⣛⠹⣮⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣷',
      '⠀⠈⠻⢦⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢩⠿⠻⣯⢻⣷⣶⣿⡿⠋⠀⠀⠀⠉⠉⠉⠉⠁⠀⣐⣭⣾⡿⠋⢻⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿',
      '⠀⠀⠀⠀⢀⣰⣿⣻⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⡿⠛⣍⠡⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟',
      '⠀⠀⠀⠀⠛⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡿⠁',
      '⠀⠀⠀⠀⢐⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⠀⠀⠀',
      '⠀⠀⠀⠀⣼⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠃⠀⠀⠀',
    },
    {
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⣿⣿⡿⠿⠿⠿⠿⠗⠶⠶⠶⠤⢤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠖⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠓⠦⣤⣤⢤⡞⢦⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢦⡀⠈⢧⡀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⢀⣄⢀⣴⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⠀⠱⣄⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⣾⠈⠉⠀⠻⡷⠀⠀⣠⠖⠚⠉⠉⠉⠉⠓⢦⡀⠀⠀⠀⠀⠀⡤⠚⠉⠉⠉⠉⠑⠢⣄⠀⠈⢧⠀⠈⢳⡀⠀⠀',
      '⠀⠀⠀⠀⠀⢰⠇⠀⠀⠀⠀⡇⢠⡞⠀⠀⠀⠀⢀⡀⠀⠀⠀⢹⠀⠀⠀⠀⢸⠁⠀⠀⡤⠀⠀⠀⠀⠈⣇⠀⠸⡆⠀⠀⢻⡄⠀',
      '⠀⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⡇⠸⡇⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⠀⠀⠀⠀⠈⠣⣀⠀⠀⠀⠀⠀⠀⣠⠇⠀⠀⡇⠀⠀⠀⢿⠀',
      '⠀⠀⠀⢀⡞⠀⠀⠀⠀⠀⠀⡇⠀⠙⠲⢤⣀⣀⣀⣀⠤⠖⠋⠀⣀⡴⠚⠓⠢⣄⡈⠙⠒⠒⠒⠒⠋⠁⠀⠀⢸⠃⠀⠀⠀⢸⡆',
      '⠀⠀⠀⣼⠁⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠴⠚⢥⡀⠀⠀⠀⡀⠙⠓⠒⠶⠦⢤⡄⠀⠀⣠⡏⠀⠀⠀⠀⢸⡇',
      '⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⢀⣤⠶⠒⠚⠋⠉⠁⠀⠀⠀⠁⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⣇⢀⡴⠋⠀⠀⠀⠀⠀⣸⠃',
      '⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⢸⣧⡀⠀⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⣄⠀⠀⠀⠀⠀⢀⡟⠀',
      '⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠘⡏⠉⠳⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡄⠀⠀⢀⡾⠁⠀',
      '⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⣠⠞⠀⠀⠀',
      '⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⠸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⢻⡏⠀⠀⠀⠀',
      '⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠹⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠟⠁⠀⢷⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠙⠦⣤⣄⣀⠀⠘⠁⠀⠀⠀⠀⠀⠙⠲⠦⣤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣤⠴⠚⠉⠀⠀⠀⠀⠈⣇⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⠀⠀',
    },
    {
      '⠀⠀⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣦⣀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢀⡙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠺⠓⠊⠉⠉⣲⠀⠈⡇⠀⠀⠀⠀⠀⣿⣿⡉⠉⠉⠑⠦⣳⡄⠀⠀⠉⠉⠉⠉⠛⠻⠿⠿⣿⣿⣿⣿⡄⠀⠀⠀⣿⠀⠀⠀⠀⠀⢻⠲⠿⣆⡀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠏⠀⣴⣿⡄⠀⠀⠀⢀⡏⠛⠃⠀⠀⠀⠀⠀⠙⠀⣠⡤⣤⣀⣠⠦⠀⠀⠀⠀⠀⣍⠻⣿⣄⠀⠀⢻⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⡸⠀⣼⣿⣿⣷⡀⠀⠀⢸⣇⠀⠀⠀⠀⠠⠄⠀⣰⡟⢉⣤⣤⡉⠁⠀⠀⠀⠀⠤⠀⠙⠁⢹⣿⣆⠀⢸⣧⡀⠀⠀⠀⠀⠸⡆⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⢰⡇⣴⣿⣿⣿⣿⣧⡀⠀⢘⡟⠁⠀⠀⠀⠀⢀⡾⢻⡄⠸⣤⣌⣿⠀⠀⠀⠀⡄⠀⠀⣤⠀⣿⣿⣿⣆⢸⣿⣿⣦⡀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⣾⡜⢹⣿⣿⣿⣿⣿⣷⡀⠐⣧⡀⠀⢀⣴⠀⠈⠙⠲⠿⠶⠴⠾⠋⠀⠀⠐⠺⠆⠀⠀⠈⠀⣿⣿⣿⣿⣾⣿⣿⣿⣟⢦⡀⠀⠀⣇⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠟⠁⢸⣿⣿⣿⣿⣿⣿⣷⡄⣟⣁⣀⣀⣠⣤⣤⣤⣤⣤⣄⣀⣀⣀⣀⣀⣀⠀⠀⠀⣴⡖⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢹⢦⡀⢸⡄⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢦⣸⠀⠙⢦⣧⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣿⣿⡿⢻⡏⠉⠉⠈⠙⠲⢬⣗⡦⣄⠀⠀⠀⣠⠄⠀⠀⣹⠉⠉⢉⣟⣿⠟⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣆⣀⣠⣽⣦⣤⣤⣴⣶⣶',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡛⡄⠀⣸⠀⠀⣴⠞⢻⡽⢿⣾⣍⢾⣿⣦⠞⠁⠀⠀⠀⢿⣤⣶⡾⢛⣾⣿⣷⠶⣄⡀⠈⠉⢹⠙⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⣷⣿⠀⣿⠀⠀⢿⡄⢿⡴⢆⡷⠹⣎⢻⠅⠀⠀⠀⠀⢀⣴⣿⠏⣴⠏⣾⢰⠎⣳⢀⣿⠂⠀⢸⠀⠀⣾⣹⡟⢹⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡏⢱⣿⡇⡟⠀⠀⠈⠳⢤⣉⣉⣤⡤⠟⠀⠀⠀⠀⠀⠀⣼⡿⠁⠀⠻⣄⣉⣓⣚⣣⡾⠃⠀⠀⢸⠀⢸⣿⠻⠃⡟⢿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣇⣿⡿⢻⡇⠀⠀⠀⠀⣀⣀⡤⠀⠀⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢰⢿⣿⡀⣰⠃⠈⢻⣿⣷⡀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢿⣷⡈⠃⣠⠤⠒⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⢠⡄⠰⢤⣀⠀⠀⠀⠀⢸⣿⣿⢟⣵⠏⠀⠀⠸⣿⣿⣷⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⠉⠙⣇⠀⠀⠀⠀⢀⣤⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢲⢤⡀⠀⠌⠙⠲⢤⡀⡼⠋⠁⣹⠋⠀⠀⠀⠀⢻⣿⣿⣄⡀⠀⣀⣀⣀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢦⠀⣿⠀⢀⡤⠞⠉⠀⠀⠀⠀⠀⠀⢀⣤⣀⢀⣀⣀⡀⠀⠀⠀⠈⠀⠈⠳⢆⡀⠀⠀⢙⣧⣀⡞⡇⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⡿⣿',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣈⣻⣹⣦⣉⣤⣤⣤⣾⣄⠀⠀⠀⠀⠈⠻⣽⣵⣟⡿⠃⠀⠀⠀⠀⠀⢧⡀⠀⠙⢦⣠⠟⢀⡿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡇⠀⠀⠀⠀⠀⠈⠛⠋⡀⢀⣀⠀⢤⡀⠀⠀⠙⢆⠀⢠⡟⠀⣸⡁⢸⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣦⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠲⠶⣶⣉⣉⣉⣉⣉⢉⣉⣭⠭⠟⠛⠀⠀⠀⠈⢳⡟⣶⠋⢸⣿⣿⣿⣿⣶⣶⣤⠀⠀⠀⠀⠀⠀⠈⠻⢿⡄',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⣰⡏⣹⣿⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀',
      '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣧⡉⡳⢦⣀⣀⠀⠀⠀⠀⣀⣠⣴⣾⢟⣵⣿⣿⣺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠃⠀⠀⠀⠀⠀⠀⠀ ',
    },
    {
      '⠀⢀⣿⣿⣿⣿⣿⣿⣿⢿⣿⡇⢹⣿⣿⣿⠈⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠀⣼⣿⣿⣿⣿⣿⣿⡟⢸⣿⡇⠈⣿⣿⣿⠀⢧⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀',
      '⢀⣿⣿⣿⣿⣿⡿⣿⣷⠸⣿⡇⠀⠹⣿⣿⣇⢈⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀',
      '⣸⣿⣿⣿⣿⣿⡇⣿⣾⡄⣿⡇⣀⣤⠽⣿⣿⡉⠉⢧⠻⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀',
      '⣿⢸⣿⣿⣿⣿⣧⣿⣿⢱⣻⡇⠀⠀⠀⠙⢻⣷⣄⣀⢳⣽⣏⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀',
      '⣿⣾⣿⣿⣿⣿⡏⣿⣾⠀⠻⣧⠀⠠⢖⣫⣽⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⡗⠚⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀',
      '⠛⣿⣿⣿⣿⡏⣧⣿⠿⡄⠀⠘⢧⠀⠸⡿⠋⠁⠈⢿⣿⣿⠗⢷⠘⣾⣿⣿⣿⣿⣿⣿⣅⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀',
      '⢸⢹⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠁⠀⠀⠀⠤⠦⠒⠉⠀⠀⠀⢧⠘⣿⣿⣿⣿⣿⣿⣧⠱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢷⠀⠀⠀⠀',
      '⣿⢸⣿⣿⣿⣿⣇⡈⢻⡟⠓⠤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⣿⣿⣿⣿⣿⣿⡿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣇⠀⠀⠀',
      '⡿⢸⣿⣿⣿⣿⣿⡈⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⢸⠀⠀⠀',
      '⡇⠸⣿⣿⣿⣿⣿⡇⣞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⠀⠀⠀',
      '⣧⠀⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⢹⣿⣏⣾⣏⣠⡧⠤⣄⣀',
      '⣿⠀⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢻⣿⡼⠟⠸⠛⠁⠀⠀⠀⠀⠀',
      '⢹⠀⢻⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⢤⣤⣤⡤⠀⠀⠀⠀⠀⠀⠀⠀⡇⣸⣿⣿⣿⣿⡟⣿⣿⣿⣿⣿⣿⣿⣯⡿⣿⣿⢃⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '⠈⡇⠸⣿⣿⣿⣿⣿⣿⣿⣷⣀⠀⠘⠦⠤⠄⠀⠀⠀⠀⠀⠀⠀⢰⠇⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⡾⢡⣿⢻⡞⠁⢀⣀⣀⣀⣀⠀⠀⠀⣀⠰⠚',
      '⠀⢹⠀⣿⣿⡇⣿⣿⣿⣿⣿⠟⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣸⣰⣿⣿⣿⣿⣿⠀⢹⣿⡿⣿⣿⣿⠟⠁⣼⠁⣸⠚⠉⠁⠀⠀⠀⠀⣠⠴⠋⠁⠀⠀',
      '⠀⠈⢳⣸⣿⡇⢻⣿⣿⣿⣿⣦⠀⢸⡷⣄⠀⠀⣀⣀⡤⢶⡋⠁⢨⢹⣿⣿⣿⣿⡇⠀⠸⣿⣧⣿⡿⠁⠀⢸⠃⢠⡇⠀⠀⠀⠀⢀⡴⠚⠁⠀⠀⠀⠀⠀',
    },
  }

  --
  -- Sections for Alpha.
  --

  local header = {
    type = 'text',
    val = Headers[math.random(#Headers)],
    -- val = Headers[1],
    opts = {
      position = 'center',
      hl = '@property',
      -- wrap = "overflow";
    },
  }

  local quotes = {
    'Sometimes the right path is not the easiest one.',
    'In the silence, we find our true selves.',
    'The shadows hold secrets we dare not uncover.',
    'Every ending is just a new beginning in disguise.',
    'Time bends, but memories remain unbroken.',
    'Embrace the chaos to find your own order.',
    'The stars whisper truths we cannot see.',
    'Lost souls wander in search of purpose.',
    'Dreams are the echoes of our deepest desires.',
    'Through darkness, light finds its way.',
    'Choices define the essence of our being.',
    'The unseen battles shape our destiny.',
    'Whispers of the past guide our future.',
    'In solitude, we discover our strength.',
    'Fragile hearts mend in unexpected ways.',
    'Echoes of silence speak louder than words.',
    'The journey inward reveals outer truths.',
    'Mysteries linger where shadows fall.',
    'Hope flickers in the darkest nights.',
    'Bound by fate, yet yearning for freedom.',
    'Silent tears tell the loudest stories.',
    'Invisible threads connect our souls.',
    "In every sorrow, there's a hidden joy.",
    'The unseen world dances with our reality.',
    'Through the veil of time, truths emerge.',
    'Whispers of the wind carry forgotten tales.',
    'Beneath the surface lies untold beauty.',
    'In the depths, we find our light.',
    'The heart sees what the eyes cannot.',
    'Silent echoes resonate through eternity.',
    'Only cunies thrive in the hours of darkness. -Lindsey',
  }

  local function get_random_quote()
    local quote = quotes[math.random(#quotes)]
    return quote
  end

  local footer = {
    type = 'text',
    val = {
      get_random_quote(),
    },
    opts = {
      position = 'center',
      hl = '@property',
    },
  }

  local buttons = {
    type = 'group',
    val = {
      button('e', '  New Buffer', 'DiagnosticSignError', ':tabnew<CR>'),
      button('f', '  Find file', 'DiagnosticSignWarn', ':Telescope find_files<CR>'),
      button('h', '  Recently opened files', 'DiagnosticSignInfo', ':Telescope oldfiles<CR>'),
      button('l', '  Projects', 'DiagnosticSignHint', ':Telescope marks<CR>'),
      --button("r", "  Frecency/MRU",          'RainbowCyan', ':Telescope oldfiles<CR>'),
      -- button('g', '  Open Last Session', 'RainbowGreen', ':source ~/.config/nvim/session.vim<CR>'),
      --button("m", "  Word Finder",           'RainbowViolet', ':Telescope live_grep<CR>'),
    },
    opts = {
      spacing = 1,
    },
  }

  --
  -- Centering handler of ALPHA
  --

  local ol = { -- occupied lines
    icon = #header.val, -- CONST: number of lines that your header will occupy
    message = #footer.val, -- CONST: because of padding at the bottom
    length_buttons = #buttons.val * 2 - 1, -- CONST: it calculate the number that buttons will occupy
    neovim_lines = 2, -- CONST: 2 of command line, 1 of the top bar
    padding_between = 3, -- STATIC: can be set to anything, padding between keybinds and header
  }

  local left_terminal_value = vim.api.nvim_get_option 'lines' - (ol.length_buttons + ol.message + ol.padding_between + ol.icon + ol.neovim_lines)

  -- Not screen enough to run the command.
  if left_terminal_value >= 0 then
    local top_padding = math.floor(left_terminal_value / 2)
    local bottom_padding = left_terminal_value - top_padding

    --
    -- Set alpha sections
    --

    options = {
      layout = {
        { type = 'padding', val = top_padding },
        header,
        { type = 'padding', val = ol.padding_between },
        buttons,
        footer,
        { type = 'padding', val = bottom_padding },
      },
      opts = {
        margin = 5,
      },
    }
  end

  --else
  --vim.api.nvim_exec('silent source ~/.config/nvim/session.vim', false)
end

return {
  'goolord/alpha-nvim',
  dependencies = 'kyazdani42/nvim-web-devicons',
  config = function()
    if options ~= nil then
      require('alpha').setup(options)
    end
  end,
}
