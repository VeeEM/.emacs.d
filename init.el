(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package ace-window
  :ensure t
  :config (global-set-key (kbd "M-o") 'ace-window))

(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0)
  :config (global-company-mode t))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil) ; should be nil when using evil-collection
  :config (evil-mode)
  :custom
  (evil-shift-width 2 "Shift by 2 spaces with < and > in evil"))

(use-package evil-collection
  :ensure t
  :config (evil-collection-init))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package gnus
  :ensure t
  :custom
  (gnus-select-method '(nntp "news.gwene.org"))
  (gnus-fetch-old-headers 'some))

(use-package magit
  :ensure t)

(use-package paredit
  :ensure t
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode))

(use-package projectile
  :ensure t
  :config
  ;; Makes projectile obey .gitignore
  ;; Depends on some Unix utilities like tr to work.
  (setq projectile-indexing-method 'alien)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

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

(use-package sr-speedbar
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

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
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default
                      nil
                      :font "DejaVu Sans Mono"
                      :height 120
		      :weight 'normal))

(set-fontset-font t 'symbol "Noto Color Emoji")

(defun veeem-forward-unless-eol ()
  "Try to move forward one character using evil-forward-char."
  (evil-forward-char 1 nil t))

; Exit insert-state after cursor, instead of before cursor
(add-hook 'evil-insert-state-exit-hook 'veeem-forward-unless-eol)

; Show column numbers
(column-number-mode)

;; Show occurance count when searching
(custom-set-variables '(isearch-lazy-count t))

(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

(setq-default buffer-file-coding-system 'utf-8-unix)
