;; styling
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq frame-title-format "%b ; %f")
(setq-default fill-column 80)
(set-face-attribute 'default t :font "Inconsolata-12")
(set-face-attribute 'vertical-border nil :foreground "#b0b0b0")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'base16-default t)
(global-visual-line-mode 1)

(desktop-save-mode 1)
(server-start)

(require 'misc)

;; temporary files
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/scratch"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; elpa
(package-initialize)
(add-to-list 'package-archives
                          '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)

;; org-mode
(setq org-agenda-files (list "~/org"))
(setq org-log-done t)
(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-log-mode t)
(setq org-default-notes-file "~/org/todo.org")
(setq org-startup-indented t)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-ndays 1)
(setq org-refile-use-outline-path 'file)
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 5))))
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-capture-templates
    '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
       "* TODO %?\n")
      ("w" "Wants" entry (file+headline "~/org/wants.org" "Wants:") "* %?")
      ("g" "Grocery" plain (file+headline "~/org/groceries.org" "Groceries")
       "- %?\n")
      ("l" "Learn" entry (file+headline "~/org/curiosity.org" "I'd like to learn about...") "* %?")
      ("f" "Freeform writing" plain (file "~/org/freewrite.org") "%t:\n\n %? \n\n----\n\n")
      ("s" "Thought" plain (file "~/org/thoughts.org") "%t: %? \n\n----\n\n")
      ("p" "Idea: programming, software" entry (file+headline "~/org/ideas.org" "Programming") "* %?")
      ("b" "Idea: blog, writing" entry (file+headline "~/org/ideas.org" "Writing") "* %?")
      ("u" "Ughs" plain (file "~/org/ugh.org") "%t: %? \n\n----\n\n")))
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; dumb jump
(setq dumb-jump-default-project "~/src")
(dumb-jump-mode)

;; markdown
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; global keybinds
(global-set-key "\C-z" 'undo)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-x\C-k" 'kill-region)
(global-unset-key [drag-mouse-1])
(global-unset-key [down-mouse-1])
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key "\C-cn" 'mc/mark-next-like-this)
(global-set-key "\C-cf" 'line-to-clipboard)
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
(global-set-key "\C-cw" 'wc)
(put 'narrow-to-region 'disabled nil)
(global-set-key (kbd "\C-c \C-s") 'bs-eshell-switch-to-and-change-dir)
(global-set-key "\C-ch" 'hoogle)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/2-2017-goals.org" "~/org/todo.org")))
 '(package-selected-packages
   (quote
    (fish-mode magit dumb-jump beeminder haskell-mode yasnippet yari wc-mode sml-mode smartparens slime sass-mode rvm ruby-tools rubocop rainbow-mode quack project-mode php-mode paredit org2blog nrepl markdown-mode magithub langtool inf-ruby helm ghc geiser flymake-easy dired+ color-theme)))
 '(quack-programs
   (quote
    ("mzscheme" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

