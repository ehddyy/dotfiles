return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
			{
				"mfussenegger/nvim-dap",
				config = function()
					local dap, dapui = require("dap"), require("dapui")
					dap.listeners.before.attach.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.launch.dapui_config = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated.dapui_config = function()
						dapui.close()
					end
					dap.listeners.before.event_exited.dapui_config = function()
						dapui.close()
					end
				end,
			},
		},
		config = function()
			require("dap_config.init").setup()
			local dapui = require("dapui")
			dapui.setup({
				-- Tu peux modifier la disposition ici si tu veux
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						position = "bottom",
						size = 10,
					},
				},
			})

			-- 3. Astuce pour la transparence : on réinitialise les fonds
			-- On dit aux fenêtres de DAP-UI d'utiliser le fond "Normal" de ton thème
			vim.api.nvim_set_hl(0, "DapUINormal", { link = "Normal" })
			vim.api.nvim_set_hl(0, "DapUINormalNC", { link = "Normal" })
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = { adapter = "python" },
					}),
					require("neotest-rust"),
				},
				status = { virtual_text = true }, -- Affiche des petits textes à côté du code
				output = { open_on_run = true }, -- Ouvre automatiquement la fenêtre de sortie en cas d'erreur
				quickfix = {
					open = function()
						if require("neotest").status.enabled then
							vim.cmd("copen") -- Ouvre la liste des erreurs en bas
						end
					end,
				},
				icons = {
					passed = "✅",
					running = "⏳",
					failed = "❌",
					skipped = "⏭️",
					unknown = "❓",
				},
				floating = {
					border = "rounded",
					max_height = 0.6,
					max_width = 0.6,
					options = {},
				},
				summary = {
					enabled = true,
					expand_errors = true,
					follow = true,
					mappings = {
						expand = { "<CR>", "o" },
						short = "i",
						stop = "u",
					},
				},
			})
		end,
	},
}
