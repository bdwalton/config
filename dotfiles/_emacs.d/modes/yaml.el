(autoload 'yaml-mode "yaml-mode" "Major mode for editing YAML files." t)
(add-to-list 'auto-mode-alist '("\\.\\(yml\\|yaml\\)$" . yaml-mode))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))