local wezterm = require("wezterm")

local mux = wezterm.mux
wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

return {
  default_cursor_style = "BlinkingBar",
  enable_scroll_bar = false,

  color_scheme = "Catppuccin Mocha",
  font = wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true }),
  font_size = 16, 
  harfbuzz_features = {
    "zero=1",
    "ss01=1",
    "ss02=1",
    "ss03=1",
    "ss04=1",
    "ss05=1",
    "ss06=1",
    "onum=0",
    "frac=0",
    "sups=0",
    "subs=0",
    "calt=1",
    "liga=1",
  },

  tab_max_width = 32,
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },

  automatically_reload_config = true,
}
