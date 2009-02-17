;; save a few keystrokes jumping to specific lines.
(global-set-key "\M-g" 'goto-line)

;; these were taken from: http://steve.yegge.googlepages.com/effective-emacs

;; make easier alt-x (when ctrl is bound to caps lock)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
