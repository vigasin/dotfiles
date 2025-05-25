-- Pull in the wezterm API
local wezterm = require("wezterm")

local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 17

config.enable_tab_bar = true

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.initial_cols = 149
config.initial_rows = 40

config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.keys = {
	-- Move (reorder) the current tab left/right
	{ key = "{", mods = "CMD|OPT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "CMD|OPT", action = act.MoveTabRelative(1) },
}

-- and finally, return the configuration to wezterm
return config
