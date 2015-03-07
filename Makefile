all: 
	rm -rf $(HOME)/.zsh
	rm -rf $(HOME)/.zshrc
	cp zshrc $(HOME)/.zshrc
	cp -pr zsh $(HOME)/.zsh
