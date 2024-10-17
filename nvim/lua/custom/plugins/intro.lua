-- Alpha (dashboard) for neovim

local options

vim.opt.termguicolors = true -- Enable true color

-- Only runs this script if Alpha Screen loads -- only if there isn't files to read
if vim.api.nvim_exec('echo argc()', true) == '0' then
  math.randomseed(os.time()) -- For random header.

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

  -- All custom headers and quotes

  local quotes = {
    '"Only cunies thrive in the darkness." Lindsey',
    '"We are what we repeatedly do. Excellence, then, is not an act, but a habit." Aristotle',
    '"To be is to be perceived." George Berkeley',
    '"The mind is furnished with ideas by experience alone." John Locke',
    '"All things excellent are as difficult as they are rare." Baruch Spinoza',
    '"Freedom is the recognition of necessity." Friedrich Engels',
    '"Life must be understood backward. But it must be lived forward." Søren Kierkegaard',
    '"Happiness is not an ideal of reason but of imagination." Immanuel Kant',
    '"The unexamined life is not worth living." Socrates',
    '"The more unintelligent a man is, the less mysterious existence seems to him." Arthur Schopenhauer',
    '"The only way to deal with this life is to find meaning in the chaos." Søren Kierkegaard',
    '"A man is but the product of his thoughts; what he thinks, he becomes." Mahatma Gandhi',
    '"He who knows others is wise; he who knows himself is enlightened." Lao Tzu',
    '"The desire for safety stands against every great and noble enterprise." Tacitus',
    '"To fear death, my friends, is only to think ourselves wise without being wise." Socrates',
    '"The man who has a why to live can bear almost any how." Friedrich Nietzsche',
    '"Time is the moving image of eternity." Plato',
    '"The people who are crazy enough to think they can change the world are the ones who do." Steve Jobs',
    '"I do not think you can name many great inventions that have been made by married men." Nikola Tesla',
    '"It’s not a faith in technology. It’s faith in people." Steve Jobs',
    '"The present is theirs; the future, for which I really worked, is mine." Nikola Tesla',
    '"Innovation distinguishes between a leader and a follower." Steve Jobs',
    '"Any sufficiently advanced technology is indistinguishable from magic." Arthur C. Clarke',
    '"The important thing is not to stop questioning. Curiosity has its own reason for existing." Albert Einstein',
    '"Do not go where the path may lead, go instead where there is no path and leave a trail." Ralph Waldo Emerson',
    '"The only limit to our realization of tomorrow is our doubts of today." Franklin D. Roosevelt',
    '"Success is not final, failure is not fatal: It is the courage to continue that counts." Winston Churchill',
    '"Imagination is more important than knowledge. For knowledge is limited, whereas imagination embraces the entire world." Albert Einstein',
    '"The journey of a thousand miles begins with one step." Lao Tzu',
    '"Believe you can and you\'re halfway there." Theodore Roosevelt',
    '"It does not matter how slowly you go as long as you do not stop." Confucius',
    '"What you do speaks so loudly that I cannot hear what you say." Ralph Waldo Emerson',
    '"I have not failed. I\'ve just found 10,000 ways that won\'t work." Thomas Edison',
    '"Our greatest glory is not in never falling, but in rising every time we fall." Confucius',
    '"The future belongs to those who believe in the beauty of their dreams." Eleanor Roosevelt',
    '"The best way to predict the future is to invent it." Alan Kay',
  }

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
    },
    {
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

  local function split(quote)
    local q, a
    if quote:sub(1, 1) == '"' then
      -- Quote is wrapped in double quotes, preserves the quotes
      q, a = quote:match '^(".*")%s+(.*)$'
    else
      -- Quote is not wrapped in quotes
      q, a = quote:match '^(.*)%.%s+(.*)$'
    end

    -- Optional: Trim any leading/trailing whitespace
    if q then
      q = q:match '^%s*(.-)%s*$'
    end
    if a then
      a = a:match '^%s*(.-)%s*$'
    end

    return q, a
  end

  -- Sections for Alpha.
  local header = {
    type = 'text',
    val = Headers[math.random(#Headers)],
    opts = {
      position = 'center',
      hl = '@property',
    },
  }

  local function get_random_quote()
    local quote = quotes[math.random(#quotes)]
    return split(quote)
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
      button('e', '󰈬  Explorer', 'DiagnosticSignError', ':Ex<CR>'),
      button('f', '  Find file', 'DiagnosticSignWarn', ':Telescope find_files<CR>'),
      button('r', '  Recently opened files', 'DiagnosticSignInfo', ':Telescope oldfiles<CR>'),
      button('p', '  Projects', 'DiagnosticSignHint', ':Telescope marks<CR>'),
      button('m', '  Mason', 'DiagnosticSignOk', ':Mason<CR>'),
    },
    opts = {
      spacing = 1,
    },
  }

  -- Centering handler of ALPHA
  local ol = { -- occupied lines
    icon = #header.val, -- CONST: number of lines that your header will occupy
    message = #footer.val, -- CONST: because of padding at the bottom
    length_buttons = #buttons.val * 2 - 1, -- CONST: it calculate the number that buttons will occupy
    neovim_lines = 2, -- CONST: 2 of command line, 1 of the top bar
    padding_between = 3, -- STATIC: can be set to anything, padding between keybinds and header
    footer_padding = 3,
  }

  local left_terminal_value = vim.api.nvim_get_option 'lines'
    - (ol.length_buttons + ol.message + ol.padding_between + ol.icon + ol.footer_padding + ol.neovim_lines)

  -- Not screen enough to run the command.
  if left_terminal_value >= 0 then
    local top_padding = math.floor(left_terminal_value / 2)
    local bottom_padding = left_terminal_value - top_padding + 2

    options = {
      layout = {
        { type = 'padding', val = top_padding },
        header,
        { type = 'padding', val = ol.padding_between },
        buttons,
        { type = 'padding', val = ol.footer_padding },
        footer,
        { type = 'padding', val = bottom_padding },
      },
      opts = {
        margin = 5,
      },
    }
  end
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
