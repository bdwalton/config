;; we want to turn on mail-mode for sup files.

;; mail-mode runs text-mode first.
;; make sure we use fill mode and turn on colors
(add-to-list 'auto-mode-alist
	     '("sup\\.\\(compose\\|forward\\|reply\\|resume\\)-mode$" . mail-mode))

;; we want colours and text-wrapping
(add-hook 'mail-mode-hook (function (lambda ()
                                      (auto-fill-mode 1)
				      (flyspell-mode 1)
				      (setq show-trailing-whitespace t)
				      )
 				    ))
