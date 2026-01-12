-- lua/plugins/telescope.lua

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				hidden = true,
				file_ignore_patterns = {}, -- Ne rien ignorer
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden", -- Inclure fichiers .env, .gitignore, etc.
					"--no-ignore", -- Ne pas suivre le .gitignore
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
				},
			},
		})

		-- Charge l'extension fzf si dispo
		pcall(telescope.load_extension, "fzf")

		-- Exemple de raccourci pour find_files avec options
		vim.keymap.set("n", "<leader>fa", function()
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = true,
			})
		end, { desc = "Find all files (incl. hidden, ignored)" })
	end,
}
