install-zshrc:
	cp zshrc $(HOME)/.zshrc

install: install-zshrc
	rm -rf $(HOME)/.zsh
	cp -pr zsh $(HOME)/.zsh
