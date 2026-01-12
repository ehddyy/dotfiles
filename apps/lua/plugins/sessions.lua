return {
	-- Plugin de gestion des sessions
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- Charger avant d'ouvrir un fichier
		opts = {
			dir = vim.fn.stdpath("data") .. "/sessions/", -- Dossier où les sessions sont enregistrées
			options = { "buffers", "curdir", "tabpages", "winsize" }, -- Ce qui est sauvegardé
		},
		config = function()
			require("persistence").setup()

			-- Keymaps pour gérer les sessions
			vim.api.nvim_set_keymap(
				"n",
				"<leader>qs",
				[[<cmd>lua require("persistence").load()<CR>]],
				{ noremap = true, silent = true, desc = "Restore session" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ql",
				[[<cmd>lua require("persistence").load({ last = true })<CR>]],
				{ noremap = true, silent = true, desc = "Restore last session" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>qd",
				[[<cmd>lua require("persistence").stop()<CR>]],
				{ noremap = true, silent = true, desc = "Delete session" }
			)
		end,
	},

	-- Plugin Dashboard avec intégration des sessions
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			local db = require("dashboard")
			db.setup({
				theme = "doom",
				config = {
					header = { "   Welcome to Neovim   " }, -- Texte d'accueil
					center = {
						{ icon = "  ", desc = "Restore Session", action = "lua require('persistence').load()" },
						{ icon = "  ", desc = "Recent Files", action = "Telescope oldfiles" },
						{ icon = "  ", desc = "Find File", action = "Telescope find_files" },
						{ icon = "  ", desc = "Find Word", action = "Telescope live_grep" },
						{ icon = "  ", desc = "New File", action = "ene | startinsert" },
						{ icon = "  ", desc = "Quit", action = "qa" },
					},
					footer = { "Neovim is Awesome!" },
				},
			})
		end,
	},
}
