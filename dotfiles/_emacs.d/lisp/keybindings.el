;; save a few keystrokes jumping to specific lines.
(global-set-key "\M-g" 'goto-line)

;; these were taken from: http://steve.yegge.googlepages.com/effective-emacs

;; make easier alt-x (when ctrl is bound to caps lock)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; macros with 1 key
(global-set-key [f4]  'start-kbd-macro)
(global-set-key [f5]  'end-kbd-macro)
(global-set-key [f6]  'call-last-kbd-macro)

;; we do this fairly often, bind it to something easy.
(global-set-key [f9] 'my-indent-all)

;; always kill the current buffer, prompting if unsaved, rather than
;; asking for the buffer name.
(global-set-key (kbd "C-x k") 'kill-this-buffer)
