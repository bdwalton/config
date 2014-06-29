;; ruby stuff

(setq interpreter-mode-alist
      (cons '("ruby19" . ruby-mode) interpreter-mode-alist))

(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
			   )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
            (define-key ruby-mode-map "\C-m" 'newline-and-indent)
	    (define-key ruby-mode-map "\C-c\C-c" 'comment-region)
	    (define-key ruby-mode-map "\C-u\C-c\C-c" 'uncomment-region)
            (require 'ruby-electric)
            (ruby-electric-mode t)
	    ))
