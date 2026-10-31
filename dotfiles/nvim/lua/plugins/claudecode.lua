local toggle_key = "<C-A>"

return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        provider = "snacks",
        snacks_win_opts = {
          position = "float",
          width = 0.9,
          height = 0.9,
          border = "rounded",
          keys = {
            claude_hide = {
              toggle_key,
              function(self)
                self:hide()
              end,
              mode = { "t", "n" },
              desc = "Hide",
            },
          },
        },
      },
    },
    keys = {
      { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    },
  },
}
