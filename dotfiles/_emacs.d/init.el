;; Wire up straight.el; We use that instead of package. Note that
;; early-init.el should be force disabling package as well.
(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

;; Any functions we need to use during init.
(defun bdw-frame-creation-hook (&optional frame)
  "Do frame-type-conditional setup."
  (with-selected-frame frame
    (if (display-graphic-p)
        (progn
          (custom-set-faces
           ;; custom-set-faces was added by Custom.
           ;; If you edit it by hand, you could mess it up, so be careful.
           ;; Your init file should contain only one such instance.
           ;; If there is more than one, they won't work right.
           '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 218 :width normal)))))
          (scroll-bar-mode -1)
          (tool-bar-mode -1)))))

;; Our basic config overrides and default settings
(add-hook 'after-make-frame-functions 'bdw-frame-creation-hook)
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(column-number-mode t)         ;; show column numbers
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)      ;; always have font colouring
;; enable a few deprecated features that we like
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq default-tab-width 2)
(setq make-backup-files nil)   ;; stop the little ~ turd files

;; General keybindings here
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
;; macros with 1 key
(global-set-key [f4]  'start-kbd-macro)
(global-set-key [f5]  'end-kbd-macro)
(global-set-key [f6]  'call-last-kbd-macro)

;; Everything else we want to do via use-package, but to ensure that
;; boostraps, use straight directly for it.
(straight-use-package 'use-package)

;; Now, teach straight to integrate itself cleanly into use-package by
;; default.
(use-package straight
  :config
  (setq straight-use-package-by-default t))

;; Various modes that we find useful
(use-package tree-sitter)
(use-package tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package go-mode)

(use-package rust-mode)

(use-package i3wm-config-mode)

(use-package ini-mode
  :straight
  (ini-mode type: git :host github :repo "Lindydancer/ini-mode" )
  :config
  (ini-mode))

(use-package markdown-mode
  :mode ("README\\.md" . gfm-mode))   ;; gfm == GitHub Flavored Markdown

(use-package systemd
  :config
  (systemd-mode))

;; General UI and creature-comfort improvements
(use-package dashboard
  :straight
  (dashboard :type git :host github :repo "emacs-dashboard/emacs-dashboard" )
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

(use-package diminish)

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package eldoc
  :diminish eldoc-mode)

(use-package autorevert
  :diminish auto-revert-mode)

(use-package hl-line
  :config
  (global-hl-line-mode t)) ;; turn it on for all modes by default

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ;; if nil, bold is universally disabled
        doom-themes-enable-italic t) ;; if nil, italics is universally disabled
  (load-theme 'doom-zenburn t)
  (doom-themes-visual-bell-config))  ;; Enable flashing mode-line on errors

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

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package term-title
  :straight
  (term-title :type git :host github :repo "CyberShadow/term-title" )
  :config
  (term-title-mode))

(use-package goto-line-faster
  :straight
  (goto-line-faster :type git :host github :repo "davep/goto-line-faster.el" ))

(use-package counsel
  :init
  ;; make easier alt-x (when ctrl is bound to caps lock)
  (global-set-key "\C-x\C-m" 'counsel-M-x)
  (global-set-key "\C-c\C-m" 'counsel-M-x)
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

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

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  ;; (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package midnight ; enable midnight mode buffer purging
  :config
  (midnight-delay-set 'midnight-delay "4:30am"))

(use-package editorconfig
  :diminish
  :config
  (editorconfig-mode 1))

;; All of our org-mode related config
(use-package org
  :config
  (require 'org-tempo) ;; Needed after org 9.2
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)))
  :custom
  (org-ellipsis " ▾")
  (org-hide-emphasis-markers t)
  (org-log-done 'time)
  (org-agenda-start-with-log-mode t)
  (org-startup-indented t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Programming related packages and config
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package apheleia
  :diminish
  :config
  (apheleia-global-mode +1))

(use-package smartparens
  :diminish
  :init
  (require 'smartparens-config)
  :hook
  (prog-mode . smartparens-mode)
  :config
  (show-smartparens-global-mode t)
  :custom
  (smartparens-strict-mode t))

(use-package aggressive-indent
  :hook
  (prog-mode . aggressive-indent-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
