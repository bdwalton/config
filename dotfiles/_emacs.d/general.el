;; stupid startup message...
(setq inhibit-startup-message t)

;; turn off menu...what's its purpose?
(menu-bar-mode -1)

;; better buffer switching
(iswitchb-mode t)

;; don't make me spell out yes/no all the time
(fset 'yes-or-no-p 'y-or-n-p)

;; always have font colouring
(global-font-lock-mode t)

;; enable a few features that we like
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Prefer 2 spaces instead of 8 for tabbed indentation
(setq default-tab-width 2)

;; stop the little ~ turd files
(setq make-backup-files nil)

;; enable midnight mode buffer purging
(setq midnight-mode t)
(midnight-delay-set 'midnight-delay "4:30am")

;; allow sgml/xml files to set indentation variables, etc.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((sgml-indent-step . 1) (sgml-indent-data . 1)))))

;; --- some stuff from djcb's dotemacs at:
;; --- http://www.djcbsoftware.nl/dot-emacs.html
;; highlight the current line
(when (fboundp 'global-hl-line-mode)
  (global-hl-line-mode t)) ;; turn it on for all modes by default
;; This works nicely with the zenburn theme
(set-face-background 'hl-line "#3e4446")

;; show-paren-mode: subtle blinking of matching paren (defaults are ugly)
;; http://www.emacswiki.org/cgi-bin/wiki/ShowParenMode
(when (fboundp 'show-paren-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis))

(column-number-mode t)                   ;; show column numbers
;; --- end of djcb's tips

;; snarfed from djcb's dotemacs
;; http://www.djcbsoftware.nl/dot-emacs.html

(autoload 'linum-mode "linum" "mode for line numbers" t)
(global-set-key (kbd "C-<f5>") 'linum-mode) ;; toggle line numbers

(defun my-indent-all ()
  "Mark the whole buffer and then indent it according to the mode rules."
  (interactive)
  (progn
    (indent-region (point-min) (point-max))))
