-- Neovide-only settings; does nothing in a terminal
if not vim.g.neovide then
  return
end

-- subpixel antialiasing (edging in neovide/config.toml) only works once the pixel layout is known;
-- RGBH = a normal, unrotated monitor
vim.g.neovide_pixel_geometry = 'RGBH'
-- darker, crisper glyph edges, closer to ClearType in Windows Terminal (default 0.5)
vim.g.neovide_text_contrast = 1.0

-- zoom: Ctrl+= bigger, Ctrl+- smaller, Ctrl+0 reset (not saved across restarts)
vim.g.neovide_scale_factor = 1.0

local function zoom(factor)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * factor
end

vim.keymap.set({ 'n', 'v', 'i' }, '<C-=>', function() zoom(1.1) end, { desc = 'Neovide: zoom in' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-->', function() zoom(1 / 1.1) end, { desc = 'Neovide: zoom out' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-0>', function() vim.g.neovide_scale_factor = 1.0 end, { desc = 'Neovide: reset zoom' })

-- cursor: no particles, and a smooth fading blink. Trail size/animation stay at their
-- defaults: trail 1.0 makes the cursor itself land instantly, so the animation adds no lag.
vim.g.neovide_cursor_vfx_mode = ''
vim.g.neovide_cursor_smooth_blink = true -- needs blinkwait/blinkon/blinkoff in guicursor
vim.opt.guicursor = {
  'n-v-c-sm:block-blinkwait700-blinkoff400-blinkon250',
  'i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250',
  'r-cr-o:hor20-blinkwait700-blinkoff400-blinkon250',
  't:block-blinkon500-blinkoff500-TermCursor',
}

-- :NeovideCursorFx [mode] tries the particle effects live; without an argument it cycles
local fx_modes = { 'railgun', 'torpedo', 'pixiedust', 'sonicboom', 'ripple', 'wireframe', 'none' }
vim.api.nvim_create_user_command('NeovideCursorFx', function(opts)
  local mode = opts.args
  if mode == '' then
    local current = vim.g.neovide_cursor_vfx_mode
    current = (current == nil or current == '') and 'none' or current
    mode = fx_modes[1]
    for i, m in ipairs(fx_modes) do
      if m == current then mode = fx_modes[i % #fx_modes + 1] end
    end
  end
  vim.g.neovide_cursor_vfx_mode = mode == 'none' and '' or mode
  vim.notify('cursor effect: ' .. mode)
end, { nargs = '?', complete = function() return fx_modes end, desc = 'Neovide: set or cycle the cursor effect' })

-- scrolling: a bit quicker than the default 0.3 s
vim.g.neovide_scroll_animation_length = 0.2

-- floating windows (completion menu, hover, diagnostics) are framed by their rounded border line
-- ('winborder', config.settings). Neovide's shadow and rounded corners outline the whole window,
-- half a cell outside that line, so they're off.
vim.g.neovide_floating_corner_radius = 0.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_floating_blur_amount_x = 3.0 -- default 2.0
vim.g.neovide_floating_blur_amount_y = 3.0

-- window: breathing room, round Windows 11 corners, no mouse pointer over the text while typing
vim.g.neovide_padding_top = 4
vim.g.neovide_padding_bottom = 4
vim.g.neovide_padding_left = 6
vim.g.neovide_padding_right = 6
vim.g.neovide_corner_preference = 'round'
vim.g.neovide_hide_mouse_when_typing = true
vim.keymap.set({ 'n', 'v', 'i' }, '<F11>', function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = 'Neovide: toggle fullscreen' })

-- title bar (Windows) in the colorscheme's own colors, following :colorscheme changes
local function match_title_bar()
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
  if normal.bg then vim.g.neovide_title_background_color = ('#%06x'):format(normal.bg) end
  if normal.fg then vim.g.neovide_title_text_color = ('#%06x'):format(normal.fg) end
end
vim.api.nvim_create_autocmd({ 'ColorScheme', 'UIEnter' }, { callback = match_title_bar })
