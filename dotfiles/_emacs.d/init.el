;; This is bdwalton's emacs config. It is auto-generated from init.org.
;; Local changes will be overwritten.

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
           '(default ((t (:family "Liberation Mono" :foundry "PfEd" :slant normal :weight normal :height 109 :width normal)))))
          (scroll-bar-mode -1)
          (tool-bar-mode -1)))))

;; Help with colorizing compilation buffers.
(defun bdw/advice-compilation-filter (f proc string)
  (funcall f proc (xterm-color-filter string)))

;; Everything else we want to do via use-package, but to ensure that
;; boostraps, use straight directly for it.
(straight-use-package 'use-package)

;; Now, teach straight to integrate itself cleanly into use-package by
;; default.
(use-package straight
  :custom
  (straight-use-package-by-default t))

(use-package emacs
  :bind
  ;; General keybindings here
  (("C-x k" . 'kill-this-buffer)
   ("C-x m" . 'execute-extended-command)
   ("C-c C-c" . 'comment-or-uncomment-region)
   ;; macros with 1 key
   ("<f4>" .  'start-kbd-macro)
   ("<f5>" . 'end-kbd-macro)
   ("<f6>" . 'call-last-kbd-macro))
  :config
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
  ;; Dump anything managed via custom-set* in a separate file
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (load custom-file))

;; Enable vertico, which provides a minimalistic vertical completion UI.
(use-package vertico
  :init
  (vertico-mode)
  ;; Show more candidates
  (setq vertico-count 15)
  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package consult-projectile
  :straight (consult-projectile :type git :host gitlab :repo "OlMon/consult-projectile" :branch "master"))

;; Consult provides completing read search and navigation support.
(use-package consult
  :after consult-projectile
  ;; Replace bindings. Lazily loaded due to `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-s" . consult-line)
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config
  (setq consult-project-buffer-sources '(consult--source-project-buffer
                                         consult--source-project-recent-file
                                         consult-projectile--source-projectile-file))
  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 3. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  ;;;; 4. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 5. No project support
  ;; (setq consult-project-function nil)
  )

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; General UI and creature-comfort improvements
(use-package dashboard
  :straight
  (dashboard :type git :host github :repo "emacs-dashboard/emacs-dashboard" )
  :config
  (dashboard-setup-startup-hook)
  :custom
  (initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (dashboard-items '((recents . 5)
                     (projects . 5))))

(use-package diminish)

(use-package eldoc
  :diminish eldoc-mode)

(use-package autorevert
  :diminish auto-revert-mode
  :config
  (global-auto-revert-mode t))

(use-package hl-line
  :config
  (global-hl-line-mode t)) ;; turn it on for all modes by default

(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)    ;; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ;; if nil, italics is universally disabled
  :config
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

(use-package project)

(use-package projectile
  :diminish projectile-mode
  :bind (:map projectile-mode-map
              ("C-x p" . projectile-command-map)
              ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
              ("C-x p f" . consult-project-buffer)
              )
  :config
  (projectile-mode)
  :custom
  (projectile-switch-project-action #'consult-project-buffer)
  (projectile-project-search-path
   '(("~/working_code/" . 1)
     ("~/working_code/go/src/github.com/bdwalton/" . 1))))

(use-package midnight ; enable midnight mode buffer purging
  :config
  (midnight-delay-set 'midnight-delay "4:30am"))

(use-package editorconfig
  :diminish
  :config
  (editorconfig-mode 1))

(use-package xterm-color
  :custom
  (compilation-environment '("TERM=xterm-256color"))
  :config
  (advice-add 'compilation-filter :around #'bdw/advice-compilation-filter))

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

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package tree-sitter
  :diminish
  :hook
  ((tree-sitter-after-on . tree-sitter-hl-mode)
   ((go-mode typescript-mode) . tree-sitter-hl-mode)))

;; Various modes that we find useful

(use-package tree-sitter-langs
  :after tree-sitter)

;; Some text completion UIs that make programming experiences richer.
(use-package company
  :diminish
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  :init
  (add-hook 'go-mode-hook #'company-mode))

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1))

(use-package eglot
  :after yasnippet
  :config
  (add-hook 'go-mode-hook #'eglot-ensure))

(use-package go-mode)

(use-package rust-mode)

(use-package i3wm-config-mode)

(use-package ini-mode
  :straight
  (ini-mode type: git :host github :repo "Lindydancer/ini-mode" )
  :config
  (ini-mode))

(use-package json-mode)

(use-package markdown-mode
  :mode ("README\\.md" . gfm-mode))   ;; gfm == GitHub Flavored Markdown

(use-package systemd
  :config
  (systemd-mode))

(use-package typescript-mode)

(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  :bind (("C-m" . 'newline-and-indent)))

(use-package protobuf-mode)

;; All of our org-mode related config
(use-package org
  :config
  (require 'org-tempo) ;; Needed after org 9.2
  (add-hook 'org-tab-first-hook 'org-end-of-line)
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

(use-package org-auto-tangle
  :diminish
  :after org
  :straight
  (org-auto-tangle type: git :host github :repo "yilkalargaw/org-auto-tangle" )
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

;; Now pull in the optional site-local config
(setq site-local-lib
      (concat
       (file-name-directory #$)
       (concat "emacs-" (getenv "BDW_CONFIG_TYPE") ".el")))
(when (file-readable-p site-local-lib)
  (load-library site-local-lib))

;; finally, always start with ~/ as the current directory
(cd (getenv "HOME"))
