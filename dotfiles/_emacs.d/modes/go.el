;; Customizations for go mode.
(add-hook 'go-mode-hook
  (lambda ()
    ; Customize compile command to run go build
    (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
    (local-set-key (kbd "C-c C-c") 'compile)))

(add-hook 'before-save-hook 'gofmt-before-save)
