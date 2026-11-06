-- Colorscheme generado por noctalia (plantilla comunitaria "lazyvim").
-- noctalia reescribe colors/noctalia.lua en cada cambio de paleta/wallpaper
-- y manda SIGUSR1 a nvim para recargarlo en vivo.
-- Si el archivo aún no existe (máquina nueva, server), cae a tokyonight.
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        if not pcall(function() vim.cmd.colorscheme("noctalia") end) then
          vim.cmd.colorscheme("tokyonight")
        end
      end,
    },
  },
}
