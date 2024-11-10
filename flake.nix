{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		flake-parts = {
			url = "github:hercules-ci/flake-parts";
			inputs.nixpkgs-lib.follows = "nixpkgs";
		};
	};

	outputs =
		inputs:
		inputs.flake-parts.lib.mkFlake { inherit inputs; } {
			systems = [
				"x86_64-linux"
				"aarch64-linux"
				"x86_64-darwin"
				"aarch64-darwin"
			];
			per-system = 
			{
				pkgs,
				config,
				lib,
				system,
				...
			}:
			{
				_module.args = {
					pkgsUnfree = import inputs.nixpkgs {
						inherit system;
						config.allowUnfree = true;
					};
				};
				flake = {
					darwinModules.default = import ./modules/default.nix; 
					nixosModules.default = import ./modules/default.nix;
					homeManagerModules.default = import ./modules/hm.nix;
				};
			};
		};
}
