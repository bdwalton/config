;; always run the server
(server-start)

;; stupid startup message...
(setq inhibit-startup-message t)

;; turn off menu...what's its purpose?
(menu-bar-mode nil)

;; better buffer switching
(iswitchb-mode t)

;; always have font colouring
(global-font-lock-mode t)

;; enable a few features that we like
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; allow sgml/xml files to set indentation variables, etc.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((sgml-indent-step . 1) (sgml-indent-data . 1)))))
