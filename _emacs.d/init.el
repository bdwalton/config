;; So that we know to look up included files in our local directory too.
(defconst user-init-dir (expand-file-name "~/.emacs.d/") "User init dir")
(add-to-list 'load-path user-init-dir)

;; make adding other paths easier
(defun my-path (p)
  "Add p to load-path (relative to ~/.emacs.d/)"
  (add-to-list 'load-path (concat user-init-dir p)))

;; which platform are we on...?
;; do other distro specific things in the distro/$localos 
(cond
 ((string-match "redhat" (emacs-version))
  (setq distro "redhat")

  )
 ((string-match "Ubuntu" (emacs-version))
  (setq distro "ubuntu")
  )
 ((string-match "solaris" (emacs-version))
  (setq distro "solaris")
  )
)

