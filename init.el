;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    material-theme                  ;; Theme
    elpy                            ;; Emacs lisp Python environment
    flycheck                        ;; On the fly syntax check. better than flymake
    blacken                         ;; Black formatting on save
    pyimport                        ;; Remove unwanted python imports
    pyimpsort                       ;; Sort python import
    magit                           ;; Git support
    powerline                       ;; Powerline
    counsel                         ;; ivy, swiper and counsel in one package
    yasnippet                       ;; snippets
    yasnippet-snippets              ;; pre-made snippets
    move-text                       ;; move text around. M-up and M-down
    py-isort                        ;; better than pyimpsort. remove the other one later
    projectile                      ;; project support
    counsel-projectile              ;; counsel UI for projectile
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)


;; ===================================
;; Basic Customization
;; ===================================

;;(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'material t)            ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally
(setq linum-format "%4d \u2502 ")   ;; Add seperator line after line number
(setq make-backup-files nil)        ;; Don't create backup files
(setq create-lockfiles nil)         ;; Don't create lock files
(setq auto-save-default nil)        ;; Don't create auto save files
(powerline-default-theme)           ;; enable powerline
(move-text-default-bindings)        ;; Move text package default configuration. M - up/down
(yas-global-mode 1)                 ;; Enable snippets
(menu-bar-mode -1)                  ;; Disable menu bar
(tool-bar-mode -1)                  ;; Disable toolbar
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;;Start maximized
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)     ;; Bar cursor rather than block
(setq ring-bell-function 'ignore)   ;; disable alarm bell

;; ===================================
;; Custom key rebindings
;; ===================================
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-p") 'aks-yank-line-below)
(global-set-key (kbd "C-x g") 'magit-status)

;; ===================================
;; IDO mode customization
;; ===================================
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


;; ===================================
;; Ivy Customization
;; ===================================
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;; ===================================
;; Projectile Customization
;; ===================================
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)
(counsel-projectile-mode)

;; ====================================
;; TREEMACS Customization
;; ====================================
;; The default width and height of the icons is 22 pixels. If you are
;; using a Hi-DPI display, uncomment this to double the icon size.
;;(treemacs-resize-icons 44)



;; ====================================
;; Development Setup
;; ====================================
;; Enable elpy
(elpy-enable)
;; Enable Flycheck 
(when (require 'flycheck nil t) 
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules)) 
(add-hook 'elpy-mode-hook 'flycheck-mode))

;; Format code and cleanup on save
(add-hook 'python-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook 'pyimport-remove-unused)
	    (add-hook 'before-save-hook 'py-isort-before-save)
	    (add-hook 'before-save-hook 'blacken-buffer)))


;;(add-hook 'before-save-hook 'pyimpsort-buffer)



;; User-Defined init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



