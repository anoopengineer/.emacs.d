;; .emacs.d/init.el

;;;;;;;;;;;;;;;;;;;
;; Preliminaries ;;
;;;;;;;;;;;;;;;;;;;

(setq debug-on-error t)                 ; Enter debugger on error
(setq message-log-max 10000)            ; Keep more log messages

;; Set GC threshold as high as possible for fast startup
(setq gc-cons-threshold most-positive-fixnum)

;; Set GC threshold back to default value when idle
(run-with-idle-timer
 10 nil
 (lambda ()
   (setq gc-cons-threshold (car (get 'gc-cons-threshold 'standard-value)))
   (message "GC threshold restored to %S" gc-cons-threshold)))

;; Force customize to put config in another file called custom.el and
;; not in init.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      MELPA Package Support      ;;
;; Enables basic packaging support ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; use-package is the only package we will install via
;; package-install. All other packages will be installed via
;; use-package later
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))


;; Our main stuff happens in the core directory.
(add-to-list 'load-path "~/.emacs.d/core/")
(require 'core-essentials)
(require 'core-ido)
(require 'core-key-bindings)
(require 'core-autocomplete)
(require 'core-python)
