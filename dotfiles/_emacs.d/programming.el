;; snarfed from djcb's dotemacs
;; http://www.djcbsoftware.nl/dot-emacs.html

(autoload 'linum-mode "linum" "mode for line numbers" t)
(global-set-key (kbd "C-<f5>") 'linum-mode) ;; toggle line numbers

(autoload 'magit-status "magit" "marius' git mode")
(global-set-key (kbd "C-<f6>") 'magit-status) 
(global-set-key (kbd "C-<f7>") 'compile)
(global-set-key (kbd "C-<f8>") 'comment-or-uncomment-region) ;; (un)comment
