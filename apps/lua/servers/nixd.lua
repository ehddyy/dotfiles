-- ================================================================================================
-- TITLE : nixd (Nix Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/nix-community/nixd
-- ================================================================================================

--- @param capabilities table LSP client capabilities
--- @return nil
return function(capabilities)
	vim.lsp.config("nixd", {
		capabilities = capabilities,
		settings = {
			nixd = {
				nixpkgs = {
					-- Permet à nixd d'évaluer les paquets nixpkgs pour l'auto-complétion
					expr = "import <nixpkgs> { }",
				},
				formatting = {
					command = { "nixpkgs-fmt" },
				},
				options = {
					-- Si tu veux l'auto-complétion des options NixOS/Home-Manager
					-- nixos = {
					--     expr = '(builtins.getFlake "/Users/antoineauer/config").nixosConfigurations.ton-nom.options',
					-- },
					home_manager = {
						expr = '(builtins.getFlake "/Users/antoineauer/.config/home-manager").homeConfigurations."antoineauer".options',
					},
				},
			},
		},
	})
end
