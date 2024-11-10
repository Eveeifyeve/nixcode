{pkgs, lib}:
{
	lib.helpers.mkVSCodeExtension {
		name = "Apc";

		options = {
			enable = lib.nixcode.defaultNullOpts.mkBool false ''
				enables the apc extension
			'';
		};

		overrides = {
			# Overrides 
		};
	};
}
