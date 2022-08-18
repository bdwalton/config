;; Activate melpa package manipulation.  Do this early so that
;; anything depending on packages will be able to find the package
;; paths, etc.

(require 'package)
(setq package-archives '(
			 ("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
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
;; macros with 1 key
(global-set-key [f4]  'start-kbd-macro)
(global-set-key [f5]  'end-kbd-macro)
(global-set-key [f6]  'call-last-kbd-macro)
;; we do this fairly often, bind it to something easy.
(global-set-key [f9] 'my-indent-all)

;; Now configure the packages we want
(use-package diminish)

(use-package smartparens
  :diminish
  :hook
  (prog-mode . smartparens-mode)
  :config
  (smartparens-strict-mode t))

(use-package ivy
  :diminish ;; hide this minor mode in the modeline
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :init
  ;; make easier alt-x (when ctrl is bound to caps lock)
  (global-set-key "\C-x\C-m" 'counsel-M-x)
  (global-set-key "\C-c\C-m" 'counsel-M-x)
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  )

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  ;; (prescient-persist-mode 1)
  (ivy-prescient-mode 1))


(use-package editorconfig
  :diminish
  :config
  (editorconfig-mode 1))

(use-package which-key
  :diminish
  :config
  (which-key-mode))

(use-package go-mode
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package rust-mode)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ;; if nil, bold is universally disabled
	doom-themes-enable-italic t) ;; if nil, italics is universally disabled
  (load-theme 'doom-zenburn t)
  (doom-themes-visual-bell-config))  ;; Enable flashing mode-line on errors

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package i3wm-config-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(i3wm-config-mode i3-config-mode helpful ivy-prescient smartparens doom-themes ivy-rich rainbow-delimiters diminish counsel editorconfig go-mode magit swiper rust-mode use-package which-key)))

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
