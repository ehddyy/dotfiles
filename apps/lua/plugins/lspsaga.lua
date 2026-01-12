return {
	"nvimdev/lspsaga.nvim",
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			ui = {
				border = "rounded",
				code_action = "💡",
			},
			symbol_in_winbar = { enable = true },

			move_in_saga = { prev = "<C-k>", next = "<C-j>" },
			finder_action_keys = { open = "<CR>" },
			definition_action_keys = { edit = "<CR>" },
		})
	end,
}
