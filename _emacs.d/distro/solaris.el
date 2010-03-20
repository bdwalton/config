(add-to-list 'load-path "/opt/csw/share/emacs/site-lisp/ruby-mode")

(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("ruby" . ruby-mode) interpreter-mode-alist))

(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

(add-hook 'ruby-mode-hook
    '(lambda ()
       (inf-ruby-keys)))

;; setup php mode autoloading on solaris
(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)

(add-to-list 'auto-mode-alist
	          '("\\.php[34]\\'\\|\\.php\\'\\|\\.phtml\\'" . php-mode))
