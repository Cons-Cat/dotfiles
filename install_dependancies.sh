pacman -Syu

# This is my fav package manager
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
paru/makepkg -si

# Replace it in Rust
pacman -S ripgrep
pacman -S fd
paru -S bottom-bin
pacman -S bat
pacman -S exa
pacman -S sd

# Other necessaries
sudo pacman -S fzf

