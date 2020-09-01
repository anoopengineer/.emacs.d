;; lsp configuration begin
(use-package lsp-mode
  :ensure t
  :custom
  ;; (lsp-log-io t)
  (read-process-output-max (* 1024 1024)) ;; 1mb
  (lsp-idle-delay 0.500)
  (lsp-enable-snippet nil)
  :hook
  ((prog-mode . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))
  )

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package lsp-ui
  :ensure t
  ;; :config
  ;; (setq-default lsp-ui-sideline-show-hover t)
  :init
  (setq lsp-ui-doc-enable nil)
  :custom
  ;; (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-delay 1.0)
  )

(use-package company
  :ensure t
  :custom
  (company-transformers '(company-sort-by-backend-importance))
  (company-idle-delay 0.05)
  (company-minimum-prefix-length 3)
  (company-selection-wrap-around t)
  (completion-ignore-case t)
  :bind
  (("C-M-i" . company-complete))
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous) 
        ("C-s" . company-filter-candidates) 
        ("C-i" . company-complete-selection)
        ([tab] . company-complete-selection))
  (:map company-search-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous))
  :init
  (global-company-mode t)
  )

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :custom
  (company-lsp-cache-candidates 'auto)
  (company-lsp-async t)
  (company-lsp-enable-recompletion t)
  :after
  (:all lsp-mode lsp-ui company yasnippet)
  :init
  (push 'company-lsp company-backends)
  )

;; lsp configuration end


(provide 'core-autocomplete)
