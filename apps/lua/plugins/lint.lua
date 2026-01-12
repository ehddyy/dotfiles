return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "flake8" },
			sh = { "shellcheck" },
			dockerfile = { "hadolint" },
			json = { "eslint_d" }, -- ou jsonlint selon ta préférence
			yaml = { "yamllint" },
			lua = { "luacheck" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			solidity = { "solhint" },
		}

		-- Trigger automatique
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
