;; detect Git's commit message editting as text mode.
(add-to-list 'auto-mode-alist
	     '("COMMIT_EDITMSG" . text-mode))


;; for most standard text files, we want auto-fill and spell checking.
(add-hook 'text-mode-hook (function (lambda ()
				      (auto-fill-mode 1)
				      (flyspell-mode 1)
				      (setq show-trailing-whitespace t)
				      )))