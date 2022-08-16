;; Activate melpa package manipulation.  Do this early so that
;; anything depending on packages will be able to find the package
;; paths, etc.

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Our custom functions
(defun my-indent-all ()
  "Mark the whole buffer and then indent it according to the mode rules."
  (interactive)
  (progn
    (indent-region (point-min) (point-max))))


;; Our basic config overrides and default settings
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t) ;; always have font colouring
;; enable a few deprecated features that we like
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq default-tab-width 2)
(setq make-backup-files nil) ;; stop the little ~ turd files
;; auto-insert the matching bracket/brace when the opening one is
;; typed
(electric-pair-mode t)
;; show-paren-mode: subtle blinking of matching paren (defaults are ugly)
;; http://www.emacswiki.org/cgi-bin/wiki/ShowParenMode
(when (fboundp 'show-paren-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis))

(when (fboundp 'global-hl-line-mode)
  (global-hl-line-mode t)) ;; turn it on for all modes by default

;; enable midnight mode buffer purging
(require 'midnight)
(midnight-delay-set 'midnight-delay "4:30am")

(column-number-mode t)                   ;; show column numbers

;; General keybindings here

(global-set-key "\M-g" 'goto-line)
;; make easier alt-x (when ctrl is bound to caps lock)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;; macros with 1 key
(global-set-key [f4]  'start-kbd-macro)
(global-set-key [f5]  'end-kbd-macro)
(global-set-key [f6]  'call-last-kbd-macro)
;; we do this fairly often, bind it to something easy.
(global-set-key [f9] 'my-indent-all)
;; Mostly for coding modes, but make it global.
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;; Now configure the packages we want
(use-package counsel)

(use-package ivy
  :diminish ;; hide this minor mode in the modeline
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-x b" . ivy-switch-buffer)
	 ("C-c C-r" . ivy-resume)
	 ("C-x C-f" . counsel-find-file))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t))

(use-package editorconfig
  :diminish
  :config
  (editorconfig-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package go-mode
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package magit)

(use-package rust-mode)

(use-package zenburn-theme)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("a3e99dbdaa138996bb0c9c806bc3c3c6b4fd61d6973b946d750b555af8b7555b" default))
 '(package-selected-packages
   '(counsel editorconfig go-mode magit swiper rust-mode use-package which-key zenburn-theme)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; now pull in the optional site-local config
(setq site-local-lib
      (concat
       (file-name-directory #$)
       (concat "emacs-" (getenv "BDW_CONFIG_TYPE") ".el")))
(when (file-readable-p site-local-lib)
  (load-library site-local-lib))

;; finally, always start with ~/ as the current directory
(cd (getenv "HOME"))
