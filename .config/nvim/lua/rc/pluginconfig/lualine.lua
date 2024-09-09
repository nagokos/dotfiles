local lualine = require("lualine")

---@type table<string, {updated:number, total:number, enabled: boolean, status:string[]}>
local mutagen = {}
local function mutagen_status()
	local cwd = vim.uv.cwd() or "."
	mutagen[cwd] = mutagen[cwd]
			or {
				updated = 0,
				total = 0,
				enabled = vim.fs.find("mutagen.yml", { path = cwd, upward = true })[1] ~= nil,
				status = {},
			}
	local now = vim.uv.now() -- timestamp in milliseconds
	local refresh = mutagen[cwd].updated + 10000 < now
	if #mutagen[cwd].status > 0 then
		refresh = mutagen[cwd].updated + 1000 < now
	end
	if mutagen[cwd].enabled and refresh then
		---@type {name:string, status:string, idle:boolean}[]
		local sessions = {}
		local lines = vim.fn.systemlist("mutagen project list")
		local status = {}
		local name = nil
		for _, line in ipairs(lines) do
			local n = line:match("^Name: (.*)")
			if n then
				name = n
			end
			local s = line:match("^Status: (.*)")
			if s then
				table.insert(sessions, {
					name = name,
					status = s,
					idle = s == "Watching for changes",
				})
			end
		end
		for _, session in ipairs(sessions) do
			if not session.idle then
				table.insert(status, session.name .. ": " .. session.status)
			end
		end
		mutagen[cwd].updated = now
		mutagen[cwd].total = #sessions
		mutagen[cwd].status = status
		if #sessions == 0 then
			vim.notify("Mutagen is not running", vim.log.levels.ERROR, { title = "Mutagen" })
		end
	end
	return mutagen[cwd]
end

local error_color = "#ff6c6b" -- 赤色
local ok_color = "#98be65"    -- 緑色

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "nordfox",
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				path = 1,
			}
		},
		lualine_x = {
			{
				function()
					local s = mutagen_status()
					if not s.enabled then
						return ""
					end
					local msg = s.total
					if #s.status > 0 then
						msg = msg .. " | " .. table.concat(s.status, " | ")
					end
					return (s.total == 0 and "󰋘 " or "󰋙 ") .. msg
				end,
				color = function()
					local s = mutagen_status()
					return (s.total == 0 or #s.status > 0) and { fg = error_color } or { fg = ok_color }
				end,
			},
			"encoding",
			"fileformat",
			"filetype"
		},
		lualine_y = { "progress" },
		lualine_z = { "location" }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {}
	},
})
