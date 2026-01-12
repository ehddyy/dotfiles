return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {
			TODO = { icon = " ", color = "info" },
			FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			IDEA = { icon = "💡", color = "hint" },
			HACK = { icon = "", color = "warning" },
			TEST = { icon = "⏱️", color = "test" },
		},
		highlight = {
			keyword = "bg", -- ou "wide", "fg", selon ta préférence
			pattern = [[.*<(KEYWORDS)\s*]], -- pour détecter les TODO même en markdown
			comments_only = false, -- <== permet de voir les TODO en dehors des commentaires
		},
		search = {
			pattern = [[\b(KEYWORDS):]], -- détecte "TODO", "FIXME:", etc.
		},
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)
	end,
}
