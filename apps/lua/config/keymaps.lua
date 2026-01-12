-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: sets some quality-of-life keymaps
-- ================================================================================================

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
-----------------------------------------------------------------
-- Center screen when jumping
-----------------------------------------------------------------

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-----------------------------------------------------------------
-- Splitting & Resizing
-----------------------------------------------------------------
vim.keymap.set("n", "<leader>uv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>uh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-----------------------------------------------------------------
-- Indentation
-----------------------------------------------------------------

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/nvim/lua/<CR>", { desc = "Edit config" })

-----------------------------------------------------------------
-- File Explorer
-----------------------------------------------------------------

-- vim.keymap.set("n", "<leader>m", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" }) -- For NerdTree
vim.keymap.set("n", "<leader>e", function()
	_G.Snacks.explorer()
end, { desc = "Toggle File Explorer" })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
-- Sauvegarder en mode Visuel
-- (On utilise <C-u> pour nettoyer la plage de sélection avant d'exécuter la commande)
vim.keymap.set("n", "<C-s>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
vim.keymap.set({ "i", "x" }, "<C-s>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Command history (le ":" de snacks)
vim.keymap.set("n", "<leader>:", function()
	_G.Snacks.picker.command_history()
end, { desc = "Command history" })

-- Search history
vim.keymap.set("n", "<leader>s/", function()
	_G.Snacks.picker.search_history()
end, { desc = "Search history" })

-- Search & Replace
vim.keymap.set("n", "<leader>sr", function()
	require("grug-far").open({ transient = true })
end, { desc = "Search and Replace (Grug-far)" })
-- Search current selected word
vim.keymap.set("n", "<leader>sw", function()
	require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "GrugFar : Remplacer le mot sous le curseur" })
-- Only current file
vim.keymap.set("n", "<leader>sf", function()
	require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "GrugFar : Remplacer dans ce fichier" })

-----------------------------------------------------------------
-- Buffer
-----------------------------------------------------------------

vim.keymap.set("n", "<C-tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<C-S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>md", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bd", function()
	_G.Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>!rm %<cr>:bd!<cr>", { desc = "Delete file" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
-- Fermer tous les buffers à droite ou à gauche
vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffers to the right" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffers to the left" })

vim.keymap.set("n", "<leader>bt", function()
	_G.Snacks.terminal()
end, { desc = "Terminal (cwd)" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set("t", "<c-t>", "<c-\\><c-n><c-w>k", { desc = "Switch away from the terminal to top window." })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>bf", function()
	require("fzf-lua").buffers()
end, { desc = "Search Tab" })

vim.keymap.set("n", "<leader>ba", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin Buffer" })

-----------------------------------------------------------------
-- Tabs
-----------------------------------------------------------------
vim.keymap.set("n", "<leader><tab>f", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "First Buffer" })
vim.keymap.set("n", "<leader><tab>l", function()
	require("bufferline").go_to_buffer(-1)
end, { desc = "Last Buffer" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>x", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.keymap.set("n", "<leader><tab>/", function()
	require("fzf-lua").buffers()
end, { desc = "Search Tab" })

vim.keymap.set("n", "<leader><tab>a", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin Buffer" })

-----------------------------------------------------------------
-- Window
-----------------------------------------------------------------
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Move in windows using <ctrl> arrow keys
-- vim.keymap.set("n", "<leader>n", "<C-w>h", { desc = "Go to left window" })
-- vim.keymap.set("n", "<leader>e", "<C-w>l", { desc = "Go to right window" })

-----------------------------------------------------------------
-- Lazy Git
-----------------------------------------------------------------
vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit.open()
end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gb", function()
	_G.Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
vim.keymap.set({ "n", "x" }, "<leader>gB", function()
	_G.Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
vim.keymap.set({ "n", "x" }, "<leader>gY", function()
	_G.Snacks.gitbrowse({
		open = function(url)
			vim.fn.setreg("+", url)
		end,
		notify = false,
	})
end, { desc = "Git Browse (copy)" })
vim.keymap.set("n", "<leader>gf", function()
	_G.Snacks.lazygit.log_file()
end, { desc = "Lazygit Current File History" })
vim.keymap.set("n", "<leader>gl", function()
	_G.Snacks.lazygit.log({ cwd = _G.LazyVim.root.git() })
end, { desc = "Lazygit Log" })
vim.keymap.set("n", "<leader>gL", function()
	_G.Snacks.lazygit.log()
end, { desc = "Lazygit Log (cwd)" })

-----------------------------------------------------------------
-- CODE
-----------------------------------------------------------------

vim.keymap.set("n", "<leader>ch", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
-----------------------------------------------------------------
-- DAP
-----------------------------------------------------------------
vim.keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
	require("dap_config").start_debugging()
end, { desc = "Continue/Start Debug" })
vim.keymap.set("n", "<leader>dn", function()
	require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Step Into" })

-- Neotest
vim.keymap.set("n", "<leader>dt", function()
	require("neotest").run.run()
end, { desc = "Run Nearest Test" })
vim.keymap.set("n", "<leader>dd", function()
	require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug Nearest Test" })

-- Markdown
vim.keymap.set("n", "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview" })

-----------------------------------------------------------------
-- LSPSAGA : Navigation & Intelligence
-----------------------------------------------------------------
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP : Aller à la définition (Fichier)" })

-- PEEK (Comportement Lspsaga : ouvre une fenêtre flottante)
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { desc = "LSP : Aperçu définition (Popup)" })
-- Finder : Chercher Définition, Références et Implémentations dans une vue unique
vim.keymap.set("n", "ch", "<cmd>Lspsaga lsp_finder<cr>", { desc = "Symbol explorator (LSP)" })

-- Peek : Voir le code sans quitter le fichier actuel (Génial pour les types ou les fonctions)
vim.keymap.set("n", "cp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek: Definition" })
vim.keymap.set("n", "ct", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Peek: Type" })

-- Documentation (Remplace le 'K' standard par une version scrollable et colorée)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Doc" })

-- Outline : Une barre latérale pour voir la structure du fichier (Classe, Fonctions, Variables)
vim.keymap.set("n", "<leader>cs", "<cmd>Lspsaga outline<cr>", { desc = "File structure" })

-- Diagnostic : Naviguer entre les erreurs avec une UI flottante
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Erreur précédente" })
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Erreur suivante" })

-- Actions de code (Fix, Import, etc.) et Renommage intelligent
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code : Actions rapides" })
vim.keymap.set("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })

-- Terminal Flottant (Lspsaga en propose un très léger)
-- vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<cr>", { desc = "Floating Term" })
-- vim.keymap.set({ "n", "t" }, "<leader>t", "<cmd>Lspsaga term_toggle<cr>", { desc = "Floating Term" })
