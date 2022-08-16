;; So that we know to look up included files in our local directory too.

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
;; This works nicely with the zenburn theme. The first is for hl-mode,
;; the second is so that when swiper highlights a line, we use the
;; same colour.
(set-face-background 'hl-line "#3e4446")
(set-face-background 'highlight "#3e4446")

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

(defconst user-init-dir
  (expand-file-name
   (concat "~" (getenv "LOGNAME") "/.emacs.d/")
   )
  "User init dir")

;; finally, always start with ~/ as the current directory
(cd (getenv "HOME"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("a3e99dbdaa138996bb0c9c806bc3c3c6b4fd61d6973b946d750b555af8b7555b" "9040edb21d65cef8a4a4763944304c1a6655e85aabb6e164db6d5ba4fc494a04" "9e3ea605c15dc6eb88c5ff33a82aed6a4d4e2b1126b251197ba55d6b86c610a1" "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" default))
 '(package-selected-packages '(go-mode zenburn-theme swiper rust-mode))
 '(safe-local-variable-values '((sgml-indent-step . 1) (sgml-indent-data . 1))))

;; now pull in the optional site-local config
(setq site-local-lib (concat user-init-dir "emacs-" (getenv "BDW_CONFIG_TYPE") ".el"))
(load-library site-local-lib)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
