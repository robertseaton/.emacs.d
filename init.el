;; styling
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq frame-title-format "%b ; %f")


(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-default-font "Tamsyn-11")
(setq default-frame-alist '((font . "Tamsyn-11")
			    (vertical-scroll-bars . nil)))

(set-fontset-font "fontset-default" 'unicode "Siji")



(set-face-attribute 'vertical-border nil :foreground "#b0b0b0")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'base16-default t)
(global-visual-line-mode 1)

(desktop-save-mode 1)
(server-start)

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'misc)

;; temporary files
(setq
   backup-by-copying t      ; don't clobber symlinks
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(setq backup-directory-alist
`((".*" . "~/scratch/")))
(setq auto-save-file-name-transforms
          `((".*" "~/scratch" t)))

(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)

(setq browse-url-browser-function 'browse-url-firefox)

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
(setq org-default-notes-file "~/org/inbox.org")
(setq org-startup-indented t)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-ndays 1)
(setq org-refile-use-outline-path 'file)
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 5))))
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'agenda))

;; open a capture frame from xmonad


(defadvice org-capture-finalize 
    (after delete-capture-frame activate)  
  "Advise capture-finalize to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
    (delete-frame)))

(defadvice org-capture-destroy 
    (after delete-capture-frame activate)  
  "Advise capture-destroy to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
    (delete-frame)))

(use-package noflet
  :ensure t)

(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")))
  (select-frame-by-name "capture")
  (delete-other-windows)
  (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
    (org-capture)))


;; wtf
(defun my-after-load-org ()
  (add-to-list 'org-modules 'org-habit)
  (add-to-list 'org-modules 'org-checklist))
(eval-after-load "org" '(my-after-load-org))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks") "* TODO %?\n")
	("l" "Links" plain (file+headline "~/org/pub/links.org" "Links") "- %?\n")
	("m" "Meditation log" item (file+headline "~/org/pub/experience.org" "Practice Log") "- %t: %?\n")
	("r" "Writing research" entry (file+headline "~/org/research.org" "Research") "* %?\n")
	("f" "Freeform writing" plain (file "~/org/freewrite.org") "%t:\n\n %? \n\n----\n\n")
	("b" "Bucket List" entry (file+headline "~/org/someday.org" "Bucket List") "* %?\n")
	("u" "Ughs" plain (file "~/org/ugh.org") "%t: %? \n\n----\n\n")))

(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODOs" ((agenda "") (alltodo "")))
	("c" "creep" tags-todo "+creep")
	("d" "de"    tags-todo "+de")))

(setq org-todo-keywords
      '((sequence "TODO(t)" "BLOCKED(b)" "|" "DONE(d)")))

(global-auto-revert-mode t)

(setq org-log-done 'time)

(require 'ox-publish)
(setq org-publish-project-alist
      '(
	("org-notes"
 :base-directory "~/org/pub"
 :base-extension "org"
 :publishing-directory "~/pub/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4             ; Just the default for this project.
 :auto-preamble t
 :auto-sitemap t
 :style "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\" />"
 :sitemap-filename "index.org" 
 :sitemap-title "rs.io" 
 )
	("org-static"
 :base-directory "~/org/pub/"
 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
 :publishing-directory "~/pub/"
 :recursive t
 :publishing-function org-publish-attachment
 )
("org" :components ("org-notes" "org-static"))
))

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-extend-today-until 4)

;; man page hooks
;; (add-hook 'Man-mode-hook 'delete-other-windows)

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
 '(org-agenda-files
   (quote
    ("~/org/inbox.org" "~/org/projects.org" "~/org/tickler.org")))
 '(package-selected-packages
   (quote
    (noflet use-package sicp smooth-scrolling weechat fish-mode magit dumb-jump beeminder haskell-mode yasnippet yari wc-mode sml-mode smartparens slime sass-mode rvm ruby-tools rubocop rainbow-mode quack project-mode php-mode paredit org2blog nrepl markdown-mode magithub langtool inf-ruby helm ghc geiser flymake-easy dired+ color-theme)))
 '(quack-programs
   (quote
    ("mzscheme" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

