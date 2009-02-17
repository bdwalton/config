;; we want to turn on mail-mode for sup files.

;; mail-mode runs text-mode first.
;; make sure we use fill mode and turn on colors
(add-to-list 'auto-mode-alist
	     '(".xml$" . xml-mode))

