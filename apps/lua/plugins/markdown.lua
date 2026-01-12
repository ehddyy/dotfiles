-- ================================================================================================
-- TITLE : markdown-preview
-- ABOUT : real-time preview of markdown files in your browser
-- LINKS : https://github.com/iamcco/markdown-preview.nvim
-- ================================================================================================

return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#until#install"]()
	end,
}
