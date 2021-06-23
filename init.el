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
  :config (company-mode))

(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config (evil-mode)
  :custom
  (evil-shift-width 2 "Shift by 2 spaces with < and > in evil"))

(use-package paredit
  :ensure t
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode))

(use-package projectile
  :ensure t
  :config
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

(setq create-lockfiles nil) ; disable lockfiles to not confuse nodejs

; Enable ido for interactive buffer and file navigation
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
; Prevent ido from suggesting files from outside current working directory
(setq ido-auto-merge-work-directories-length -1)
(ido-mode t)

; 2 space indentation for Javascript
(setq js-indent-level 2)

; Don't re-indent on newline
(setq electric-indent-mode nil)

; Scroll at constant speed using the scroll wheel
(setq mouse-wheel-progressive-speed nil)

; Set default fonts
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default
                      nil
                      :font "DejaVu Sans Mono"
                      :height 160
		      :weight 'bold))

(set-fontset-font t 'symbol "Noto Color Emoji")

(defun veeem-forward-unless-eol ()
  "Try to move forward one character using evil-forward-char."
  (evil-forward-char 1 nil t))

; Exit insert-state after cursor, instead of before cursor
(add-hook 'evil-insert-state-exit-hook 'veeem-forward-unless-eol)

; Show column numbers
(column-number-mode)

(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)
