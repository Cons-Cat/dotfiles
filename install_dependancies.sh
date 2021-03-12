sudo pacman -Syu

# This is my fav package manager
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
paru/makepkg -si

# Replace it in Rust
sudo pacman -S ripgrep
sudo pacman -S fd
sudo pacman -S bat
sudo pacman -S exa
sudo pacman -S sd
paru -S bottom-bin

# Other necessaries
sudo pacman -S fzf
sudo pacman -S fish
sudo pacman -S clang
sudo pacman -S kitty
paru -S emacs-native-comp-git-enhanced

