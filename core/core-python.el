(defun python-template ()
  (interactive)
  (insert "#!/usr/bin/env python3\n# -*- coding: utf-8 -*-\n\n"))

(add-hook 'python-mode-hook
          '(lambda () (when (eq (buffer-size) 0) (python-template))))

(defun aks-python-install-deps ()
  (interactive)
  (shell-command "pip install 'python-language-server[rope,pydocstyle,pyflakes]' pyls-mypy black 'ptvsd>=4.2'"))

(use-package blacken
  :ensure t
  :after (python)
  :init
  (add-hook 'python-mode-hook #'blacken-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp))))  ; or lsp-deferred

(use-package pyimport
  :ensure t)

(use-package py-isort
  :ensure t)

(use-package pyimpsort
  :ensure t)

(use-package pyvenv
  :ensure t)

(defun pyvenv-autoload ()
  "Automatically activates pyvenv version if venv directory exists."
  (f-traverse-upwards
   (lambda (path)
     (let ((venv-path (f-expand "venv" path)))
       (if (f-exists? venv-path)
           (progn
             (pyvenv-workon venv-path))
             t)))))

(add-hook 'python-mode-hook 'pyvenv-autoload)

(add-hook 'python-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook 'pyimport-remove-unused)
	    (add-hook 'before-save-hook 'py-isort-before-save)
	    (add-hook 'before-save-hook 'blacken-buffer)))
(add-hook 'before-save-hook 'pyimpsort-buffer)



(provide 'core-python)
;;; core-python.el ends here
