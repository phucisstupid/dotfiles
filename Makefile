.PHONY: install-nix switch update write-flake

install-nix:
	curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes

switch:
	@nh='nh'; \
		if ! command -v nh >/dev/null 2>&1; then nh='nix run nixpkgs#nh --'; fi; \
		if [ "$$(uname)" = Darwin ]; then \
		$$nh darwin switch . -H "$$(hostname -s)"; \
		else \
		$$nh os switch . -H "$$(hostname -s)"; \
		fi

update:
	nix flake update
	$(MAKE) switch

write-flake:
	nix run .#write-flake
