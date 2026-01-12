local M = {}

-- Default template
local default_launch_json = [[
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Current File",
      "type": "python",
      "request": "launch",
      "program": "${file}",
      "console": "integratedTerminal"
    },
    {
      "name": "Rust: Debug",
      "type": "codelldb",
      "request": "launch",
      "program": "${executable}",
      "args": [],
      "cwd": "${workspaceFolder}"
    }
  ]
}
]]

-- Charge or create launch.json
function M.start_debugging()
	local vscode = require("dap.ext.vscode")
	local vscode_dir = vim.fn.getcwd() .. "/.vscode"
	local launch_json = vscode_dir .. "/launch.json"

	local function continue()
		require("dap").continue()
	end

	if vim.fn.filereadable(launch_json) == 0 then
		vim.ui.select({ "Yes", "No" }, {
			prompt = "No launch.json found. Create default ?",
		}, function(choice)
			if choice == "Yes" then
				if vim.fn.isdirectory(vscode_dir) == 0 then
					vim.fn.mkdir(vscode_dir, "p")
				end
				local file = io.open(launch_json, "w")
				if file then
					file:write(default_launch_json)
					file:close()
					vscode.load_launchjs(nil, { python = { "python" }, codelldb = { "rust" } })
					vim.schedule(continue)
				end
			else
				vim.schedule(continue)
			end
		end)
	else
		vscode.load_launchjs(nil, { python = { "python" }, codelldb = { "rust" } })
		continue()
	end
end

function M.setup()
	require("dap_config.python")
	require("dap_config.rust")
	vim.fn.sign_define("DapBreakpoint", { text = "🚩", texthl = "DapBreakpoint" })

	require("dap.ext.vscode").type_to_filetypes = {
		python = { "python" },
		codelldb = { "rust" },
	}
end

return M
