bind \eg 'bit; commandline -f repaint; echo --'
bind \eG 'lazygit'

bind \el 'echo --; exa -labh -a -s name --no-user --group-directories-first --git --color-scale --icons; commandline -f repaint; echo --'

zoxide init fish | source
bind \en 'commandline z\ '

bind \er 'reset'
bind \ex	'delete-line'
bind \eh 'backward-kill-word'
bind \eo 'kill-word'
bind \ey 'backward-kill-line'
bind \ei 'kill-line'
bind \ea 'insert-line-under'
bind \ek 'insert-line-over'
bind \em 'eval command sudo $history[1]'

starship init fish | source

