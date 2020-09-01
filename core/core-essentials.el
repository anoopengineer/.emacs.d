;; ===================================
;; Basic Customization
;; ===================================

;;(setq inhibit-startup-message t)    ;; Hide the startup message
(global-linum-mode t)               ;; Enable line numbers globally
(setq linum-format "%4d \u2502 ")   ;; Add seperator line after line number
(setq make-backup-files nil)        ;; Don't create backup files
(setq create-lockfiles nil)         ;; Don't create lock files
(setq auto-save-default nil)        ;; Don't create auto save files
(menu-bar-mode -1)                  ;; Disable menu bar
(tool-bar-mode -1)                  ;; Disable toolbar
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;;Start maximized
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)     ;; Bar cursor rather than block
(setq ring-bell-function 'ignore)   ;; disable alarm bell
(winner-mode 1)                     ;; enable winner mode
(setq-default buffer-file-coding-system 'utf-8) ;; Set the default encoding to UTF-8.
(setenv "LANG" "en_be.UTF-8")       ;; Set the default encoding to UTF-8.
(prefer-coding-system 'utf-8)       ;; Set the default encoding to UTF-8.
(setq-default indent-tabs-mode nil) ;; never indent with tabs

;; Set up some better Emacs defaults
(use-package better-defaults
  :ensure t
  )


;;Ensure packages are downloaded by default globally
(require 'use-package-ensure)
(setq use-package-always-ensure t)


;; Material theme
(use-package material-theme
  :ensure t
  :load-path "themes"
  :config
  (load-theme 'material t)
  )

;; Powerline
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )

;; move text around. M-up and M-down
(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings)
  )

;; Snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  )

(use-package yasnippet-snippets
  :ensure t
  )

;; Magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; ivy, swiper and counsel in one package. Helm is too complex
(use-package counsel
  :ensure t
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

;; Smart Parenthesis
(use-package smartparens
  :ensure t)

;; Hail Hydra
(use-package hydra
  :ensure t)
(use-package use-package-hydra
  :ensure t)



(defun aks-yank-line-below ()
  "copy current line and yank it to the next line.
Cursor doesn't move."
  (interactive)
  (setq init-point (point))
  (save-excursion
    (beginning-of-line)
    (setq beg-point (point))
    (end-of-line)
    (setq end-point (point))
    (setq line-text (delete-and-extract-region end-point beg-point))
    (insert line-text)
    (newline)
    (insert line-text))
  (goto-char init-point))

;; ===================================
;; Ivy Customization
;; ===================================
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))


(use-package ace-jump-mode
  :ensure t
  :bind ("C-." . ace-jump-mode))

(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window))

;;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; Zygospore, make C-x 1 toggleable
(use-package zygospore
  :ensure t
  :commands (zygospore-toggle-delete-other-windows)
  :bind ("C-x 1" . zygospore-toggle-delete-other-windows))

;; Golden ratio on window splits
(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode
  :config
  (add-to-list 'golden-ratio-extra-commands 'ace-window)
  :init
  (golden-ratio-mode t))


(provide 'core-essentials)

