return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			sign_priority = 6, -- Priorité des signes
			update_debounce = 200, -- Temps d'attente pour la mise à jour

			current_line_blame = true, -- ✅ Active le `git blame` directement dans la marge
			current_line_blame_opts = {
				virt_text = true, -- ✅ Active le texte virtuel dans la marge
				virt_text_pos = "eol", -- Position du texte (fin de ligne)
				delay = 500, -- Délai avant affichage (en ms)
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

			-- Raccourcis clavier utiles
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local map = function(mode, lhs, rhs, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				-- Navigation entre les changements
				map("n", "]c", function()
					gs.next_hunk()
				end, { desc = "Next Git Hunk" })
				map("n", "[c", function()
					gs.prev_hunk()
				end, { desc = "Previous Git Hunk" })

				-- Gestion des hunks
				map("n", "<leader>hs", function()
					gs.stage_hunk()
				end, { desc = "Stage Hunk" })
				map("n", "<leader>hr", function()
					gs.reset_hunk()
				end, { desc = "Reset Hunk" })
				map("n", "<leader>hp", function()
					gs.preview_hunk()
				end, { desc = "Preview Hunk" })
				map("n", "<leader>hb", function()
					gs.blame_line()
				end, { desc = "Blame Line" })
				map("n", "<leader>tb", function()
					gs.toggle_current_line_blame()
				end, { desc = "Toggle Git Blame" })
			end,
		})
	end,
}
