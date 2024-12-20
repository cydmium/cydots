local iron = require("iron.core")

iron.setup({
  config = {
    scratch_repl = true,
    repl_open_cmd = require("iron.view").split.vertical.botright(0.5),
  },
  keymaps = {
    send_motion = "<localleader>s",
    visual_send = "<localleader>s",
    send_file = "<localleader>sf",
    send_line = "<localleader>ss",
    cr = "<localleader>s<cr>",
    interrupt = "<localleader>s<localleader>",
    exit = "<localleader>sq",
    clear = "<localleader>cl",
  },
  highlight = { italic = true },
  ignore_blank_lines = true,
})
