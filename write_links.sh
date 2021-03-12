# Symlink Kitty term
if test -d ./kitty/kitty-themes
	git clone https://github.com/dexpota/kitty-themes ./kitty/kitty-themes/
end
rm ~/.config/kitty/*
ln -s ./kitty/* ~/.config/kitty/

# Symlink Fish shell
# Kitties looove fish!
rm -R ~/.config/fish/
ln -s ./fish/

