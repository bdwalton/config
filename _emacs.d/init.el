;; So that we know to look up included files in our local directory too.

(defconst user-init-dir
  (expand-file-name
   (concat "~" (getenv "LOGNAME") "/.emacs.d/")
   )
  "User init dir")

(add-to-list 'load-path user-init-dir)

;; make adding other paths easier
(defun extra-user-path (p)
  "Add p to load-path (relative to ~/.emacs.d/)"
  (add-to-list 'load-path (concat user-init-dir p)))

(defun cond-load-file (f)
  "Conditionally load a file based on whether or not it exists"
  (if (file-exists-p f)
      (load f)))

;; a library from
;; http://www.splode.com/~friedman/software/emacs-lisp/src/emacs-variants.el
;; that allows us to grab components from the version string to load various
;; things in different versions
(load-library "emacs-variants")

(extra-user-path "distro") ;; put distro specific (path?) things here.
(extra-user-path "emacsvers") ;; version specific things.

;; which platform are we on...?
;; do other distro specific things in the distro/$localos 
;; ...things like setting additional distro specific load paths are smart
;; here
(cond
 ((string-match "Ubuntu" (emacs-version))
  (setq distro "ubuntu")
  )
 (t
  (message "Encountered an unknown distro")
  (setq distro "unknown")
  )
)

(cond-load-file (concat user-init-dir "distro/" distro ".el"))

;; load things we need only in the specific version (eg: set keybindings
;; that are defaults in new versions, etc)
(cond-load-file
 (concat user-init-dir "emacsvers/" (int-to-string (emacs-version-major)) ".el"))

;; some generic settings that should work everywhere.
(load-library "general")

;; keybindings that we want everywhere.
(load-library "keybindings")

;; automatically load all of the .el files in our modes/ directory
(mapc 'load-library
      (directory-files (concat user-init-dir "modes") t "\\.el\\'"))

;; finally, always start with ~/ as the current directory
(cd (getenv "HOME"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((sgml-parent-document . "../machines.xml") (sgml-indent-step . 1) (sgml-indent-data . 1)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
