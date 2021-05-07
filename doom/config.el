(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon nil)
(setq doom-modeline-modal-icon t)
(setq doom-modeline-buffer-state-icon nil)

;; Aesthetics
(setq doom-theme 'doom-one-light)
(setq doom-font 'monoid)
(setq doom-font (font-spec :family "Monoid" :size 12 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 11 :weight 'light))

(add-hook! 'prog-mode-hook 'ligature-mode)
(ligature-set-ligatures '(prog-mode) '("->" "<-" "==" "!=" "::" "!!" "=>" "<=" ">=" "//" "/*" "*/" ":=" "<<" ">>" "__" "___" "/**" "&&" "||"))

;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

;; Make like Kakoune-ish
(after! evil-escape (evil-escape-mode -1))
(setq evil-move-beyond-eol t)
;; (after! evil (setq evil-want-o/O-to-continue-comments nil))
(setq evil-want-o/O-to-continue-comments nil)
(setq evil-move-cursor-back nil)
(map! :after evil :n "U" (cmd! (evil-redo 1)))

;; C++ Coding
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(defun eol-colon ()
  (interactive)
  (end-of-line)
  (insert ";"))

(map! :after evil :i "C-o" (cmd! (eol-colon)
                  (newline)
                  (indent-according-to-mode)))

(map! :after evil :i "C-O" (cmd! (eol-colon)(normal-mode)))

;; TODO replace with regex.
(map! :after evil :map prog-mode-map :nvom "(" (lambda!(sp-down-sexp)))
(map! :after evil :map prog-mode-map :nvom ")" (lambda!(sp-up-sexp)))
