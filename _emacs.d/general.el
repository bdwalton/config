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
