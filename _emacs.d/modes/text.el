;; for most standard text files, we want auto-fill and spell checking.
(add-hook 'text-mode-hook (function (lambda ()
				      (auto-fill-mode 1)
				      (flyspell-mode 1)
				      )))