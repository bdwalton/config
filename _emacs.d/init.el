;; So that we know to look up included files in our local directory too.
(defconst user-init-dir (expand-file-name "~/.emacs.d/") "User init dir")
(add-to-list 'load-path user-init-dir)

;; make adding other paths easier
(defun extra-user-path (p)
  "Add p to load-path (relative to ~/.emacs.d/)"
  (add-to-list 'load-path (concat user-init-dir p)))

(extra-user-path "distro") ;; put distro specific (path?) things here.
(extra-user-path "modes") ;; put mode specific settings in here.

;; which platform are we on...?
;; do other distro specific things in the distro/$localos 
;; ...things like setting additional distro specific load paths are smart
;; here
(cond
 ((string-match "redhat" (emacs-version))
  (load-library "redhat")
  )
 ((string-match "Ubuntu" (emacs-version))
  (load-library "ubuntu")
  )
 ((string-match "solaris" (emacs-version))
  (load-library "solaris")
  )
 ((true)
  (message "Encountered an unknown distro")
)

;; some generic settings that should work everywhere.
(load-library "general")

(load-libray "ruby")