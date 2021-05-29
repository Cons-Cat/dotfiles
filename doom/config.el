;; Basic Doom configuration.
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon nil)
(setq doom-modeline-modal-icon t)
(setq doom-modeline-buffer-state-icon nil)

;; Aesthetics.
(setq doom-theme 'leuven)
(setq doom-font (font-spec :family "MonoLisa" :size 13 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 13 :weight 'light))
;; (set-face-font 'mode-line "Roboto")

(setq centaur-tabs-height 16)
(setq centaur-tabs-set-close-button nil)
(setq centaur-tabs--buffer-show-groups t)
(setq centaur-tabs-set-bar 'under)
(setq x-underline-at-descent-line t)

;; (custom-set-faces!
;;   '(font-lock-operator-face :family "MonoLisa"))

(setq-default line-spacing 0.18)

;; TODO Fix this after! macro.
;; (after! ligaturel
  (add-hook! 'prog-mode-hook 'ligature-mode)
;; TODO: <=> does not work.
  (ligature-set-ligatures '(prog-mode) '("///" "->" "<-" "==" "!=" "::" "!!" ;; "=>" "<=" ">="
                                         "//"
                                         "/*" "*/" ":=" "<<" ">>" "__" "___" "/**" "&&" "##"
                                         "||" "-->" "<--" "/=" "*=" "www" ";;" ".." "..." ".?"))

;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

;; Make like Kakoune-ish.
(after! evil-escape (evil-escape-mode -1))
;; TODO: These don't work.
;; (setq evil-move-beyond-eol t)
;; (setq evil-want-o/O-to-continue-comments nil)
;; (setq evil-move-cursor-back nil)
(map! :after evil :n "U" (cmd! (evil-redo 1)))

(map! :after evil :n "~" 'evil-operator-string-inflection)

;; C++ coding.
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
;; (after! lsp-ui
;;   (setq lsp-ui-doc-enable nil))
;; (add-hook! 'c++-mode-hook )
;; (after! lsp-mode)
;; (require 'dap-cpptools)

(after! lsp-mode
  (add-hook! 'prog-mode-hook 'lsp-semantic-tokens-mode)
  (custom-set-faces! '(lsp-face-semhl-operator :family "Cascadia Code"))
  ;; (map! evil :mode c++-mode :leader "clgo" 'lsp-clangd-find-other-file)
  )

(defun eol-colon ()
  (interactive)
  (end-of-line)
  (insert ";"))

;; TODO: Bind to C-i ?
;; (map! :after evil :i "C-o" (cmd! (eol-colon)
;;                   (newline)
;;                   (indent-according-to-mode)))
(map! :after evil :i "C-i" (cmd! (eol-colon)(normal-mode)))

;; (after! smartparens
;;   (sp-local-pair 'c++-mode "<" ">" :actions nil))

;; Programming in general.

(add-hook! lisp-data-mode-hook 'rainbow-delimiters-mode)
;; TODO replace with regex.
(map! :after evil :map prog-mode-map :nvm "(" (cmd!(sp-slurp-hybrid-sexp)))
(map! :after evil :map prog-mode-map :nvm ")" (cmd!(sp-forward-barf-sexp)))
;; TODO Config sp-forward-sexp and sp-backward-up-sexp
;; CCLS has similar functions.

(setq read-process-output-max (*( * 1024 1024 )2)) ;; 2mb
