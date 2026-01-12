-- ================================================================================================
-- TITLE : which-key
-- ABOUT : WhichKey helps you remember your Neovim keymaps, by showing keybindings as you type.
-- LINKS :
--   > github : https://github.com/folke/which-key.nvim
-- ================================================================================================

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- Configuration de base
		spec = {
			-- On définit ici les noms des groupes pour chaque lettre
			{ "<leader>/", group = "Grep" },
			{ "<leader><tab>", group = "Tabs" },
			{ "<leader>f", group = "Find" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debugger" },
			{ "<leader>s", group = "Search" },
			{ "<leader>x", group = "Trouble" },
			{ "<leader>g", group = "Git/Go" },
			{ "<leader>q", group = "Session/Quit" },
			{ "<leader>u", group = "Interface (UI)" },
			{ "<leader>b", group = "Buffers" },
			-- On peut même faire des sous-groupes
			{ "<leader>gs", group = "Git Statut/Stage" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
