-- Gutter of one cell per mark: git bar, diagnostic, then the line number ("┃E 12 code").
-- Neovim's own sign column draws every sign 2 cells wide, and 'signcolumn=auto' resized it
-- whenever an error appeared; this keeps a fixed width and shows both marks side by side.
-- Signs from anything else share the diagnostic cell (a diagnostic on the same line wins).
-- Set as 'statuscolumn' in config.settings (with 'signcolumn' off).
local M = {}

-- first character of a sign's text ("E " -> "E", "┃ " -> "┃"), or a blank
local function cell(mark, blank_hl)
  local text = mark and vim.fn.strcharpart(vim.trim(mark.sign_text or ''), 0, 1) or ''
  if text == '' then return '%#' .. blank_hl .. '# ' end
  return '%#' .. (mark.sign_hl_group or 'SignColumn') .. '#' .. (text:gsub('%%', '%%%%'))
end

local function higher(a, b)
  if not a or b.priority > a.priority then return b end
  return a
end

function M.render()
  local win = vim.g.statusline_winid
  local wo = vim.wo[win]
  -- windows without line numbers (nvim-tree, ...) keep their plain sign column
  if not (wo.number or wo.relativenumber) then return '%s' end

  local buf = vim.api.nvim_win_get_buf(win)
  local width = math.max(wo.numberwidth - 1, #tostring(vim.api.nvim_buf_line_count(buf)))
  if vim.v.virtnum ~= 0 then -- wrapped or virtual line
    return string.rep(' ', width + 3)
  end

  -- highest-priority git, diagnostic and other sign on this line
  local lnum = vim.v.lnum
  local git, diag, other
  local signs = vim.api.nvim_buf_get_extmarks(buf, -1, { lnum - 1, 0 }, { lnum - 1, -1 },
    { type = 'sign', details = true })
  for _, extmark in ipairs(signs) do
    local d = extmark[4]
    if d.sign_text then
      local hl = d.sign_hl_group or ''
      if hl:find('^GitSigns') then
        git = higher(git, d)
      elseif hl:find('^DiagnosticSign') then
        diag = higher(diag, d)
      else
        other = higher(other, d)
      end
    end
  end

  local relnum = vim.v.relnum
  local num = (wo.relativenumber and (relnum ~= 0 or not wo.number)) and relnum or lnum
  local num_hl = (wo.cursorline and relnum == 0) and 'CursorLineNr' or 'LineNr'
  return cell(git, num_hl) .. cell(diag or other, num_hl)
      .. '%#' .. num_hl .. '#' .. string.format('%' .. width .. 'd ', num)
end

return M
