return {
	"ellisonleao/dotenv.nvim",
	config = function()
		require("dotenv").setup({
			enable_on_load = true, -- Charge automatiquement le .env au démarrage
			verbose = false, -- Ne te bombarde pas de messages
		})
	end,
}
