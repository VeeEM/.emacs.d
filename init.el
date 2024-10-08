(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package ace-window
  :ensure t
  :config (global-set-key (kbd "M-o") 'ace-window))

(use-package boogie-friends
  :ensure t
  :custom (flycheck-dafny-executable "dafny"))

(use-package cc-mode
  :hook ((c-mode c++-mode) . veeem-disable-flycheck)
  :config
  (define-key c-mode-map (kbd "C-c C-c") #'compile)
  (define-key c++-mode-map (kbd "C-c C-c") #'compile))

(use-package cmake-ts-mode
  :init (add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-ts-mode)))

(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0)
  :config (global-company-mode t))

(use-package company-coq
  :ensure t
  :hook coq-mode)

(use-package cuda-mode
  :ensure t)

(use-package diff-mode
  :config
  (keymap-set diff-mode-map "M-o" nil))

(use-package eglot
  :ensure t
  :config
  (define-key eglot-mode-map (kbd "C-c a") 'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c f") 'eglot-format))

(use-package elisp-refs
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil) ; should be nil when using evil-collection
  :config
  (evil-mode)
  :custom
  (evil-shift-width 2 "Shift by 2 spaces with < and > in evil"))

(use-package evil-collection
  :ensure t
  :config (evil-collection-init))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :custom (flycheck-disabled-checkers (list 'coq)))

(use-package gnus
  :ensure t
  :custom
  (gnus-select-method '(nntp "news.gwene.org"))
  (gnus-fetch-old-headers 'some))

(use-package haskell-mode
  :ensure t)

(use-package magit
  :ensure t)

;; Useful shortcuts for org-mode:
;; C-c C-, to insert structure template
;; C-c C-x C-l to preview Latex
(use-package org
  :ensure t
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)
     (python . t)
     (gnuplot .t)
     (shell . t)))
  (plist-put org-format-latex-options :scale 2.0))

(use-package paredit
  :ensure t
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode))

(use-package pipenv
  :ensure t
  :hook (python-mode . pipenv-mode)
  :init
  (setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended))

;; The poke package requires this package, but it is currently not
;; specified in the package itself. If we try to use poke without
;; having manually installed poke-mode, it will just not work.
(use-package poke-mode
  :ensure t)

(use-package poke
  :ensure t)

(use-package projectile
  :ensure t
  :config
  ;; Makes projectile obey .gitignore
  ;; Depends on some Unix utilities like tr to work.
  ;; (setq projectile-indexing-method 'alien)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package proof-general
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :config
  (custom-set-faces
    '(rainbow-delimiters-depth-1-face ((t (:foreground "forest green"))))
    '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
    '(rainbow-delimiters-depth-3-face ((t (:foreground "dark orange"))))
    '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
    '(rainbow-delimiters-depth-5-face ((t (:foreground "medium blue"))))
    '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
    '(rainbow-delimiters-depth-7-face ((t (:foreground "medium purple"))))
    '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1"))))
    '(rainbow-delimiters-depth-9-face ((t (:foreground "saddle brown")))))
  :hook ((lisp-mode emacs-lisp-mode) . rainbow-delimiters-mode))

(use-package slime
  :ensure t
  :custom
  (sldb-initial-restart-limit 20))

(use-package which-key
  :ensure t
  :config (which-key-mode)
  :custom (which-key-idle-secondary-delay 0.1))

(use-package yaml-mode
  :ensure t)

(global-display-line-numbers-mode)

(setq display-line-numbers-type 'relative)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
(setq auto-save-default nil)
(setq create-lockfiles nil) ; disable lockfiles to not confuse nodejs

;; Performance settings for lsp-mode
(setq gc-cons-threshold 100000000) ; Allow more garbage before collecting
(setq read-process-output-max (* 1024 1024)) ; Read bigger chunks from subprocess
(setq lsp-log-io nil) ; Disable logging

; Enable ido for interactive buffer and file navigation
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
; Prevent ido from suggesting files from outside current working directory
(setq ido-auto-merge-work-directories-length -1)
(ido-mode t)

; 2 space indentation for Javascript
(setq js-indent-level 2)

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(use-package web-mode
  :ensure t
  :mode (("\\.js\\'" . web-mode)
	 ("\\.jsx\\'" . web-mode)
	 ("\\.ts\\'" . web-mode)
	 ("\\.tsx\\'" . web-mode)
	 ("\\.html\\'" . web-mode)
	 ("\\.htm\\'" . web-mode))
  :commands web-mode)

; Don't re-indent on newline
(setq electric-indent-mode nil)

; Scroll at constant speed using the scroll wheel
(setq mouse-wheel-progressive-speed nil)

; Set default fonts
(set-face-attribute 'default
                    nil
                    :font "DejaVu Sans Mono"
                    :height 120
		    :weight 'normal)

(set-fontset-font t 'symbol "Noto Color Emoji")

(defun veeem-forward-unless-eol ()
  "Try to move forward one character using evil-forward-char."
  (evil-forward-char 1 nil t))

(defun veeem-pwd-to-load-path ()
  "Add current working directory to load-path."
  (interactive)
  (add-to-list 'load-path (expand-file-name ".")))

(defun veeem-insert-em-dash ()
  "Insert an em-dash at point."
  (interactive)
  (insert-char ?—))

(defun veeem-disable-flycheck ()
  "Disable flycheck-mode."
  (flycheck-mode 0))

(global-set-key (kbd "C-c i -") #'veeem-insert-em-dash)

; Exit insert-state after cursor, instead of before cursor
(add-hook 'evil-insert-state-exit-hook 'veeem-forward-unless-eol)

; Show column numbers
(column-number-mode)

;; Show occurance count when searching
(custom-set-variables '(isearch-lazy-count t)
		      '(inferior-lisp-program "sbcl")
		      '(lsp-java-format-on-type-enabled nil)
		      '(tramp-default-method "ssh"))

;; Enable fill-column-indicator-mode upon entering text and prog mode
(add-hook 'text-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; Enable Ansi Colors in compilation-mode
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)

;; Highlight current line in package-list-packages
(add-hook 'package-menu-mode-hook #'hl-line-mode)

(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

(setq-default buffer-file-coding-system 'utf-8-unix)
(put 'upcase-region 'disabled nil)

(add-to-list 'display-buffer-alist '("*Help*" display-buffer-reuse-window))

(defun veeem-jump-todo (N)
"Jump to TODO N."
(interactive "nWhich todo?")
(save-window-excursion
  (rgrep (concat "TODO " (number-to-string N) ":") "*" ".")
(with-current-buffer "*grep*"
  (message (concat "current mode is " (prin1-to-string major-mode)))
  (add-hook 'compilation-finish-functions #'veeem-open-first-result nil t))))

(defun veeem-open-first-result (buffer result)
  "Open the first result in compilation mode."
  (let ((todo-buffer-position
	 ;; save-window-excursion does not affect windows that are
	 ;; opened in a different frame.
	 (save-window-excursion 
	   (with-current-buffer buffer
	     (remove-hook 'compilation-finish-functions #'veeem-open-first-result t)
	     (compilation-next-error 1)
	     (compile-goto-error)
	     ;(next-error)
	     (cons (current-buffer) (point))))))
    (switch-to-buffer (car todo-buffer-position))
    (goto-char (cdr todo-buffer-position))))

(defun veeem-read-todo-nr ()
  (let*
      ((current-line (thing-at-point 'line))
       (todo-nr-string
	(prog2
	    (string-match
	     "TODO \\([[:digit:]]+\\)"
	     current-line)
	    (match-string 1 current-line)))
       (todo-nr (if todo-nr-string
		    (string-to-number todo-nr-string)
		  nil)))
    todo-nr))

