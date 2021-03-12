# Symlink Kitty term
if test !  -d ./kitty/kitty-themes
	git clone https://github.com/dexpota/kitty-themes ./kitty/kitty-themes/
end
rm ~/.config/kitty/*
cp ./kitty/kitty.conf ~/.config/kitty/kitty.conf

# Kitties looove fish!
if test ! -d ./oh-my-fish
	git clone https://github.com/oh-my-fish/oh-my-fish
	oh-my-fish/bin/install --offline
	omf install bobthefish
end
rm -R ~/.config/fish/
mkdir ~/.config/fish
cp -R ./fish/* ~/.config/fish/

# Pacman / Paru
sudo rm /etc/pacman.conf
sudo rm /etc/paru.conf
sudo cp ./etc/pacman.conf /etc/pacman.conf
sudo cp ./etc/paru.conf /etc/paru.conf

# Plasma
rm ~/.config/kglobalshortcutsrc
cp ./kde/kglobalshortcutsrc
