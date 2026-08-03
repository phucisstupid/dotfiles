.PHONY: switch update install-nix

switch:
	@nh='nh'; \
		if ! command -v nh >/dev/null 2>&1; then nh='nix run nixpkgs#nh --'; fi; \
		if [ "$$(uname)" = Darwin ]; then \
		$$nh darwin switch . -H "$$(hostname -s)"; \
		else \
		$$nh os switch . -H "$$(hostname -s)"; \
		fi

update:
	nix run .#write-flake
	nix flake update
	$(MAKE) switch

install-nix:
	@if [ "$$(uname)" != "Darwin" ]; then \
		echo "install-nix is only supported on macOS."; \
		exit 0; \
		fi
	@if command -v nix >/dev/null 2>&1; then \
		echo "Nix is already installed."; \
		else \
		echo "Installing Nix..."; \
		curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes; \
		fi
