-- What a language server is busy with, and for how long, for the statusline.
-- dartls reports no percentages and says nothing during its first project scan (~10 s on a
-- 500-file app), so this counts elapsed seconds instead:
--   "starting"  from attach until the server first reports back,
--   a request's method once one has waited over half a second (e.g. workspace/symbol),
--   "analyzing" while it sends $/progress.
local M = {}

local clients = {} -- client id -> { name, attached, reported, busy_since, last_progress, requests }
local function now() return vim.uv.hrtime() / 1e6 end
local function secs(ms) return math.floor(ms / 1000) end

function M.setup()
  local group = vim.api.nvim_create_augroup('lsp_status', { clear = true })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and not clients[client.id] then
        clients[client.id] = { name = client.name, attached = now(), requests = {} }
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspProgress', {
    group = group,
    callback = function(ev)
      local c = clients[ev.data.client_id]
      if not c then return end
      local t = now()
      -- dartls sends one empty begin/end right at attach; only later progress is a real report
      if t - c.attached > 1000 then c.reported = true end
      c.busy_since = c.busy_since or t
      c.last_progress = t
    end,
  })

  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = group,
    callback = function(ev)
      local ns = ev.data.diagnostics[1] and ev.data.diagnostics[1].namespace
      for id, c in pairs(clients) do
        if ns == vim.lsp.diagnostic.get_namespace(id, false) or ns == vim.lsp.diagnostic.get_namespace(id, true) then
          c.reported = true
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspRequest', {
    group = group,
    callback = function(ev)
      local c = clients[ev.data.client_id]
      if not c then return end
      if ev.data.request.type == 'pending' then
        c.requests[ev.data.request_id] = { method = ev.data.request.method, t = now() }
      else
        c.requests[ev.data.request_id] = nil
      end
    end,
  })
end

-- '' when every server on the current buffer is idle
function M.status()
  local t = now()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    local c = clients[client.id]
    if c then
      if not c.reported and t - c.attached < 5 * 60 * 1000 then
        return ('󰔟 %s: starting %ds'):format(c.name, secs(t - c.attached))
      end
      local oldest
      for _, r in pairs(c.requests) do
        if t - r.t > 500 and (not oldest or r.t < oldest.t) then oldest = r end
      end
      if oldest then
        return ('󰔟 %s: %s %ds'):format(c.name, (oldest.method:gsub('^textDocument/', '')), secs(t - oldest.t))
      end
      if c.last_progress and t - c.last_progress < 1500 then
        return ('󰔟 %s: analyzing %ds'):format(c.name, secs(t - c.busy_since))
      end
      c.busy_since = nil
    end
  end
  return ''
end

return M
